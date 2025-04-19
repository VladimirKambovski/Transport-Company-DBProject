CREATE VIEW view_detailed_route_info AS
SELECT 
    r.id AS route_id,
    r.route_start,
    r.route_end,
    s1.id AS start_station_id,
    s2.id AS end_station_id,
    l1.Name AS start_location_name,
    l2.Name AS end_location_name,
    c1.Name AS start_country_name,
    c2.Name AS end_country_name,
    r.departtime,
    r.arrivaltime
FROM 
    Route r
JOIN 
    Station s1 ON r.route_start = s1.ID
JOIN 
    Station s2 ON r.route_end = s2.ID
JOIN 
    Location l1 ON s1.LocationID = l1.ID
JOIN 
    Location l2 ON s2.LocationID = l2.ID
JOIN 
    Country c1 ON l1.CountryID = c1.ID
JOIN 
    Country c2 ON l2.CountryID = c2.ID
WHERE 
    s1.id = s2.id; 




CREATE VIEW view_route_sections AS
SELECT 
    r.id AS route_id,
    st1.ID AS start_station_id,
    l1.Name AS start_station_name,
    st2.ID AS end_station_id,
    l2.Name AS end_station_name,
    s.sectionOrder
FROM 
    Section s
JOIN 
    Route r ON s.RouteID = r.id
JOIN 
    Station st1 ON s.StationID = st1.ID
JOIN 
    Station st2 ON s.StationID2 = st2.ID
JOIN 
    Location l1 ON st1.LocationID = l1.ID
JOIN 
    Location l2 ON st2.LocationID = l2.ID
ORDER BY 
    r.id, s.sectionOrder;





CREATE VIEW view_stations_with_locations AS
SELECT 
    s.ID AS station_id,
    l.Name AS location_name,
    c.Name AS country_name
FROM 
    Station s
JOIN 
    Location l ON s.LocationID = l.ID
JOIN 
    Country c ON l.CountryID = c.ID;


