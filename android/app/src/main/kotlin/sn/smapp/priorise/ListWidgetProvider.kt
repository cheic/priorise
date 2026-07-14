package sn.smapp.priorise

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class ListWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val count = widgetData.getInt("list_count", 0)

            val views = RemoteViews(context.packageName, R.layout.widget_list)

            val titleIds = intArrayOf(
                R.id.list_title_1, R.id.list_title_2,
                R.id.list_title_3, R.id.list_title_4,
                R.id.list_title_5
            )
            val checkIds = intArrayOf(
                R.id.list_check_1, R.id.list_check_2,
                R.id.list_check_3, R.id.list_check_4,
                R.id.list_check_5
            )
            val rowIds = intArrayOf(
                R.id.list_task_1, R.id.list_task_2,
                R.id.list_task_3, R.id.list_task_4,
                R.id.list_task_5
            )

            for (i in 0 until 5) {
                if (i < count) {
                    val title = widgetData.getString("list_title_$i", "") ?: ""
                    val done = widgetData.getBoolean("list_done_$i", false)

                    views.setViewVisibility(rowIds[i], android.view.View.VISIBLE)
                    views.setTextViewText(titleIds[i], title)
                    views.setImageViewResource(
                        checkIds[i],
                        if (done) R.drawable.ic_check_filled else R.drawable.ic_check_empty
                    )
                } else {
                    views.setViewVisibility(rowIds[i], android.view.View.GONE)
                }
            }

            if (count == 0) {
                views.setViewVisibility(R.id.list_empty, android.view.View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.list_empty, android.view.View.GONE)
            }

            // Counter
            val total = widgetData.getInt("stats_total", 0)
            val done = widgetData.getInt("stats_done", 0)
            views.setTextViewText(R.id.list_counter, "$done / $total")

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
