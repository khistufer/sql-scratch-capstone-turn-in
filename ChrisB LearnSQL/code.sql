{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf100
{\fonttbl\f0\fmodern\fcharset0 CourierNewPSMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl280\partightenfactor0

\f0\fs24 \cf2 \expnd0\expndtw0\kerning0
-- Show unique utm_campaigns
\f1 \

\f0 SELECT DISTINCT utm_campaign
\f1 \

\f0 FROM page_visits;
\f1 \
\

\f0 -- Show unique utm_sources
\f1 \

\f0 SELECT DISTINCT utm_source
\f1 \

\f0 FROM page_visits;
\f1 \
\

\f0 -- Show unique webpages on the website
\f1 \

\f0 SELECT DISTINCT page_name
\f1 \

\f0 FROM page_visits;
\f1 \
\

\f0 --Create temporary query table for First Touch and attributes
\f1 \
\

\f0 WITH first_touch AS (
\f1 \

\f0 \'a0\'a0\'a0 SELECT user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0 MIN(timestamp) as first_touch_at
\f1 \

\f0 \'a0\'a0\'a0 FROM page_visits
\f1 \

\f0 \'a0\'a0\'a0 GROUP BY user_id),
\f1 \

\f0 ft_attr AS (
\f1 \

\f0 \'a0 SELECT ft.user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 ft.first_touch_at,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_campaign
\f1 \

\f0 \'a0 FROM first_touch ft
\f1 \

\f0 \'a0 JOIN page_visits pv
\f1 \

\f0 \'a0\'a0\'a0 ON ft.user_id = pv.user_id
\f1 \

\f0 \'a0\'a0\'a0 AND ft.first_touch_at = pv.timestamp
\f1 \

\f0 )
\f1 \
\

\f0 SELECT ft_attr.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 ft_attr.utm_campaign,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 COUNT(*)
\f1 \

\f0 FROM ft_attr
\f1 \

\f0 GROUP BY 1, 2
\f1 \

\f0 ORDER BY 3 DESC;
\f1  \
\

\f0 --Create temporary query table for Last Touch and attributes
\f1 \
\

\f0 WITH last_touch AS (
\f1 \

\f0 \'a0\'a0\'a0 SELECT user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0 MAX(timestamp) as last_touch_at
\f1 \

\f0 \'a0\'a0\'a0 FROM page_visits
\f1 \

\f0 \'a0\'a0\'a0 GROUP BY user_id),
\f1 \

\f0 lt_attr AS (
\f1 \

\f0 \'a0 SELECT lt.user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 lt.last_touch_at,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_campaign
\f1 \

\f0 \'a0 FROM last_touch lt
\f1 \

\f0 \'a0 JOIN page_visits pv
\f1 \

\f0 \'a0\'a0\'a0 ON lt.user_id = pv.user_id
\f1 \

\f0 \'a0\'a0\'a0 AND lt.last_touch_at = pv.timestamp
\f1 \

\f0 )
\f1 \

\f0 SELECT lt_attr.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 lt_attr.utm_campaign,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 COUNT(*)
\f1 \

\f0 FROM lt_attr
\f1 \

\f0 GROUP BY 1, 2
\f1 \

\f0 ORDER BY 3 DESC;
\f1 \
\

\f0 --Create temporary query table for Visitor and Last Touch Purchase
\f1 \
\

\f0 SELECT COUNT(DISTINCT user_id) AS \'91Visitor Purchases\'92
\f1 \

\f0 FROM page_visits
\f1 \

\f0 WHERE page_name = "4 - purchase";
\f1 \
\

\f0 WITH last_touch AS (
\f1 \

\f0 \'a0\'a0\'a0 SELECT user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0 MAX(timestamp) as last_touch_at
\f1 \

\f0 \'a0\'a0\'a0 FROM page_visits
\f1 \

\f0 \'a0\'a0\'a0 WHERE page_name = "4 - purchase"
\f1 \

\f0 \'a0\'a0\'a0 GROUP BY user_id),
\f1 \

\f0 lt_attr AS (
\f1 \

\f0 \'a0 SELECT lt.user_id,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 lt.last_touch_at,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 pv.utm_campaign
\f1 \

\f0 \'a0 FROM last_touch lt
\f1 \

\f0 \'a0 JOIN page_visits pv
\f1 \

\f0 \'a0\'a0\'a0 ON lt.user_id = pv.user_id
\f1 \

\f0 \'a0\'a0\'a0 AND lt.last_touch_at = pv.timestamp
\f1 \

\f0 )
\f1 \

\f0 SELECT lt_attr.utm_source,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 lt_attr.utm_campaign,
\f1 \

\f0 \'a0\'a0\'a0\'a0\'a0\'a0 COUNT(*)
\f1 \

\f0 FROM lt_attr
\f1 \

\f0 GROUP BY 1, 2
\f1 \

\f0 ORDER BY 3 DESC;
\f1  \
}