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
  "description": "Visualize Amazon EBS metrics",
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": 3,
  "links": [],
  "panels": [
    {
      "datasource": {
        "uid": "$datasource"
      },
      "description": "",
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
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "Write"
            },
            "properties": [
              {
                "id": "custom.transform",
                "value": "negative-Y"
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 9,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 2,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "right",
          "showLegend": false
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
          "alias": "Read",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "VolumeId": "*"
          },
          "expression": "SUM(REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeReadBytes\"', 'Sum', $period)))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "VolumeReadBytes",
          "metricQueryType": 0,
          "namespace": "AWS/EBS",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        },
        {
          "alias": "Write",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {
            "VolumeId": "*"
          },
          "expression": "SUM(REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeWriteBytes\"', 'Sum', $period)))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "VolumeReadBytes",
          "metricQueryType": 0,
          "namespace": "AWS/EBS",
          "period": "$period",
          "refId": "B",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Total volumes read (+) and write (-) [bytes/sec]",
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
        "y": 9
      },
      "id": 12,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [],
          "displayMode": "list",
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
            "VolumeId": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeReadBytes\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "VolumeReadBytes",
          "metricQueryType": 0,
          "namespace": "AWS/EBS",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Volume READ per instance [bytes/sec]",
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
        "y": 9
      },
      "id": 11,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [],
          "displayMode": "list",
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
            "VolumeId": "*"
          },
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeWriteBytes\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "VolumeReadBytes",
          "metricQueryType": 0,
          "namespace": "AWS/EBS",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Sum"
        }
      ],
      "title": "Volume WRITE per instance [bytes/sec]",
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
        "y": 18
      },
      "id": 13,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [],
          "displayMode": "list",
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
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeReadOps\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume READ per instance [IOPS]",
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
        "y": 18
      },
      "id": 14,
      "options": {
        "dataLinks": [],
        "legend": {
          "calcs": [],
          "displayMode": "list",
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
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeWriteOps\"', 'Sum', $period))/$period",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume WRITE per instance [IOPS]",
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
        "y": 27
      },
      "id": 15,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeTotalReadTime\"', 'Sum', $period))",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume READ per instance [total sec in this period]",
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
        "y": 27
      },
      "id": 16,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeTotalWriteTime\"', 'Sum', $period))",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume WRITE per instance [total sec in this period]",
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
        "y": 36
      },
      "id": 17,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeIdleTime\"', 'Sum', $period))/$period*100",
          "hide": false,
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume idle time per instance [%]",
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
        "y": 36
      },
      "id": 18,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeQueueLength\"', 'Sum', $period))",
          "hide": false,
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume queue length [number of requests]",
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
        "y": 45
      },
      "id": 21,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeThroughputPercentage\"', 'Average', $period))",
          "hide": false,
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume throughput per instance [% IOPS delivered/provisioned]",
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
        "y": 45
      },
      "id": 22,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"VolumeConsumedReadWriteOps\"', 'Sum', $period))",
          "hide": false,
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Volume consumed read write ops per instance [count of 256K capacity units]",
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
        "y": 54
      },
      "id": 23,
      "options": {
        "dataLinks": []
      },
      "targets": [
        {
          "alias": "{{label}}",
          "datasource": {
            "uid": "$datasource"
          },
          "dimensions": {},
          "expression": "REMOVE_EMPTY(SEARCH('{AWS/EBS,VolumeId} MetricName=\"BurstBalance\"', 'Sum', $period))",
          "hide": false,
          "id": "",
          "matchExact": true,
          "metricEditorMode": 1,
          "metricName": "",
          "metricQueryType": 0,
          "namespace": "",
          "period": "$period",
          "refId": "A",
          "region": "$region",
          "statistic": "Average"
        }
      ],
      "title": "Burst balance per instance [%]",
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
        "y": 63
      },
      "id": 20,
      "options": {},
      "title": "Info",
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
    "EBS"
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
  "title": "Amazon EBS",
  "uid": "MP7gaHbZz",
  "version": 1
}
