{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "datasource",
          "uid": "grafana"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "description": "Visualize Amazon CloudWatch Log based metrics",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": 5,
  "links": [],
  "panels": [
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 10,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "stepAfter",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "never",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 2,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [
            "mean"
          ],
          "displayMode": "table",
          "placement": "right",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.1",
      "targets": [
        {
          "alias": "",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/Logs,LogGroupName} MetricName=\"IncomingLogEvents\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "IncomingLogEvents",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Incoming log events [count/sec]",
      "type": "timeseries"
    },
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 10,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "stepAfter",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "never",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "decbytes"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 24,
        "x": 0,
        "y": 8
      },
      "id": 3,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [
            "mean"
          ],
          "displayMode": "table",
          "placement": "right",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.1",
      "targets": [
        {
          "alias": "",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/Logs,LogGroupName} MetricName=\"IncomingBytes\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "IncomingLogEvents",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Incoming bytes [bytes/sec]",
      "type": "timeseries"
    },
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 10,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "stepAfter",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "never",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 0,
        "y": 16
      },
      "id": 4,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [
            "mean"
          ],
          "displayMode": "table",
          "placement": "right",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.1",
      "targets": [
        {
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "",
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "DeliveryErrors",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Delivery errors [count]",
      "type": "timeseries"
    },
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 10,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "stepAfter",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "never",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 12,
        "y": 16
      },
      "id": 5,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [
            "mean"
          ],
          "displayMode": "table",
          "placement": "right",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.1",
      "targets": [
        {
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "",
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "DeliveryThrottling",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Delivery throttling [count]",
      "type": "timeseries"
    },
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 0,
        "y": 25
      },
      "id": 6,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/Logs,LogGroupName} MetricName=\"ForwardedLogEvents\"', 'Sum', $period))/$period",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "ForwardedLogEvents",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Forwarded log events [count/sec]",
      "type": "timeseries"
    },
    {
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 12,
        "y": 25
      },
      "id": 7,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "LogGroupName": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/Logs,LogGroupName} MetricName=\"ForwardedBytes\"', 'Sum', $period))/$period",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "ForwardedBytes",
          "metricQueryType": 0,
          "namespace": "AWS/Logs",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Forwarded bytes [bytes/sec]",
      "type": "timeseries"
    },
    {
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "gridPos": {
        "h": 2,
        "w": 24,
        "x": 0,
        "y": 34
      },
      "id": 9,
      "options": {},
      "title": " ",
      "type": "text"
    }
  ],
  "preload": false,
  "refresh": "",
  "schemaVersion": 41,
  "tags": [
    "Amazon",
    "AWS",
    "CloudWatch",
    "Logs"
  ],
  "templating": {
    "list": [
      {
        "current": {
          "text": "default",
          "value": "default"
        },
        "includeAll": false,
        "label": "Data source",
        "name": "datasource",
        "options": [],
        "query": "cloudwatch",
        "refresh": 1,
        "regex": "",
        "type": "datasource"
      },
      {
        "current": {
          "text": "default",
          "value": "default"
        },
        "datasource": "$datasource",
        "definition": "regions()",
        "includeAll": false,
        "label": "Region",
        "name": "region",
        "options": [],
        "query": "regions()",
        "refresh": 1,
        "regex": "",
        "type": "query"
      },
      {
        "current": {
          "text": "300",
          "value": "300"
        },
        "includeAll": false,
        "label": "Period [sec]",
        "name": "period",
        "options": [
          {
            "selected": false,
            "text": "60",
            "value": "60"
          },
          {
            "selected": true,
            "text": "300",
            "value": "300"
          },
          {
            "selected": false,
            "text": "3600",
            "value": "3600"
          }
        ],
        "query": "60,300,3600",
        "type": "custom"
      }
    ]
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Amazon CloudWatch Logs",
  "uid": "5lKoAHxZz",
  "version": 1
}
