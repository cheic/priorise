package sn.smapp.priorise

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class MatrixWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val q1 = widgetData.getInt("matrix_q1", 0)
            val q2 = widgetData.getInt("matrix_q2", 0)
            val q3 = widgetData.getInt("matrix_q3", 0)
            val q4 = widgetData.getInt("matrix_q4", 0)

            val views = RemoteViews(context.packageName, R.layout.widget_matrix)

            views.setTextViewText(R.id.matrix_q1_count, q1.toString())
            views.setTextViewText(R.id.matrix_q2_count, q2.toString())
            views.setTextViewText(R.id.matrix_q3_count, q3.toString())
            views.setTextViewText(R.id.matrix_q4_count, q4.toString())

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
