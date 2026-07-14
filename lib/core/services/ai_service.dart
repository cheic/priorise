import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/role_model.dart';
import '../models/task_model.dart';
import '../models/mission_model.dart';
import '../di/injection.dart';
import '../services/database_service.dart';

import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';

class AiService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Future<Map<String, String>> synthesizeReview({
    required String provider,
    required String apiKey,
    required List<LifeRole> roles,
    required List<Task> tasks,
    required String currentWorked,
    required String currentSlipped,
  }) async {
    // 1. Prepare prompt
    final db = getIt<DatabaseService>();
    final mission = await db.isar.missions.where().findFirst();
    
    final missionContext = mission?.statement ?? "Non définie";
    final rolesContext = roles.map((r) => r.name).join(', ');
    final tasksContext = tasks.map((t) {
      final role = roles.firstWhere((r) => r.id == t.roleId, orElse: () => LifeRole()..name = 'Autre');
      return "- [${t.done ? 'x' : ' '}] ${t.title} (${role.name})${t.important && !t.urgent ? ' [Grosse Pierre]' : ''}";
    }).join('\n');

    final locale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final isEn = locale == 'en';

    final prompt = isEn ? '''
As a productivity assistant (Priorise app), analyze my week.
My life mission: $missionContext
Defined roles: $rolesContext
Tasks of the week: 
$tasksContext

Current user reflections:
What worked: $currentWorked
What slipped: $currentSlipped

Give me a kind and constructive feedback to prepare my weekly review, relying (if relevant) on my life mission.
Give me two short and impactful texts:
1. whatWorked: "What worked well..." (Congratulate and summarize successes, max 2 sentences)
2. whatSlipped: "Attention point..." (Gently advise on what wasn't done, max 2 sentences)

Return the result in strict JSON format:
{
  "whatWorked": "...",
  "whatSlipped": "..."
}
Do not include anything else, no markdown, no surrounding text.
''' : '''
En tant qu'assistant de productivité (application Priorise), analyse ma semaine.
Ma mission de vie : $missionContext
Mes rôles définis : $rolesContext
Tâches de la semaine : 
$tasksContext

Réflexions actuelles de l'utilisateur :
Ce qui a marché : $currentWorked
Ce qui a dérapé : $currentSlipped

Fais-moi un retour bienveillant et constructif pour préparer le bilan de ma semaine, en t'appuyant (si pertinent) sur ma mission de vie.
Donne-moi deux textes courts et percutants :
1. whatWorked: "Ce qui a bien fonctionné..." (Félicite et résume les réussites, max 2 phrases)
2. whatSlipped: "Le point d'attention..." (Conseille doucement sur ce qui n'a pas été fait, max 2 phrases)

Renvoie-moi le résultat au format JSON strict :
{
  "whatWorked": "...",
  "whatSlipped": "..."
}
N'inclus que le JSON, pas de markdown, pas de texte autour.
''';

    // 2. Call the provider API
    String resultJson = '';

    try {
      if (provider == 'Claude') {
        resultJson = await _callAnthropic(apiKey, prompt);
      } else if (provider == 'Gemini') {
        resultJson = await _callGemini(apiKey, prompt);
      } else {
        // GPT, Kimi, Qwen, Mistral all use OpenAI-compatible endpoints
        resultJson = await _callOpenAICompatible(provider, apiKey, prompt);
      }

      // 3. Parse JSON
      // Clean markdown if the AI wrapped it (e.g. ```json ... ```)
      resultJson = resultJson.trim();
      if (resultJson.startsWith('```json')) {
        resultJson = resultJson.substring(7);
      } else if (resultJson.startsWith('```')) {
        resultJson = resultJson.substring(3);
      }
      if (resultJson.endsWith('```')) {
        resultJson = resultJson.substring(0, resultJson.length - 3);
      }

      final data = jsonDecode(resultJson.trim());
      return {
        'whatWorked': data['whatWorked'] ?? 'Pas de retour généré.',
        'whatSlipped': data['whatSlipped'] ?? 'Pas de retour généré.',
      };
    } catch (e) {
      throw Exception('Erreur de communication avec $provider. Vérifiez votre clé API et votre connexion.');
    }
  }

  Future<String> _callOpenAICompatible(String provider, String apiKey, String prompt) async {
    String endpoint;
    String model;

    switch (provider) {
      case 'Mistral':
        endpoint = 'https://api.mistral.ai/v1/chat/completions';
        model = 'mistral-small-latest';
        break;
      case 'Qwen':
        endpoint = 'https://dashscope-intl.aliyuncs.com/compatible-mode/v1/chat/completions';
        model = 'qwen-turbo';
        break;
      case 'Kimi':
        endpoint = 'https://api.moonshot.cn/v1/chat/completions';
        model = 'moonshot-v1-8k';
        break;
      case 'GPT':
      default:
        endpoint = 'https://api.openai.com/v1/chat/completions';
        model = 'gpt-4o-mini';
        break;
    }

    final response = await _dio.post(
      endpoint,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
      data: {
        'model': model,
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.7,
      },
    );

    if (response.statusCode == 200) {
      return response.data['choices'][0]['message']['content'];
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  Future<String> _callAnthropic(String apiKey, String prompt) async {
    final response = await _dio.post(
      'https://api.anthropic.com/v1/messages',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'anthropic-dangerous-direct-browser-access': 'true', // Sometimes required from mobile apps without backend
        },
      ),
      data: {
        'model': 'claude-3-haiku-20240307',
        'max_tokens': 300,
        'temperature': 0.7,
        'messages': [
          {'role': 'user', 'content': prompt}
        ]
      },
    );

    if (response.statusCode == 200) {
      return response.data['content'][0]['text'];
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  Future<String> _callGemini(String apiKey, String prompt) async {
    final url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';
    final response = await _dio.post(
      url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        'contents': [
          {'parts': [{'text': prompt}]}
        ],
        'generationConfig': {
          'temperature': 0.7,
          'responseMimeType': 'application/json',
        }
      },
    );

    if (response.statusCode == 200) {
      return response.data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  Future<bool> testConnection({required String provider, required String apiKey}) async {
    try {
      if (apiKey.trim().length < 5) return false;
      
      String result = '';
      if (provider == 'Claude') {
        result = await _callAnthropic(apiKey, "Dis 'OK'");
      } else if (provider == 'Gemini') {
        result = await _callGemini(apiKey, "Dis 'OK'");
      } else {
        result = await _callOpenAICompatible(provider, apiKey, "Dis 'OK'");
      }
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
