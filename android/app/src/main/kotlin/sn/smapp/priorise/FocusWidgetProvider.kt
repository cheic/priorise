package sn.smapp.priorise

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class FocusWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val hasTask = widgetData.getBoolean("focus_has_task", false)
            val title = widgetData.getString("focus_title", "") ?: ""
            val role = widgetData.getString("focus_role", "") ?: ""

            val views = RemoteViews(context.packageName, R.layout.widget_focus)

            if (hasTask && title.isNotEmpty()) {
                views.setTextViewText(R.id.focus_title, title)
                views.setTextViewText(R.id.focus_role, "STRATÉGIQUE · $role")
                views.setViewVisibility(R.id.focus_content, android.view.View.VISIBLE)
                views.setViewVisibility(R.id.focus_empty, android.view.View.GONE)
            } else {
                views.setViewVisibility(R.id.focus_content, android.view.View.GONE)
                views.setViewVisibility(R.id.focus_empty, android.view.View.VISIBLE)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
