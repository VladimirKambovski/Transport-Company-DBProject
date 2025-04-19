-------procedures

--dodavanje novi ruti

CREATE PROCEDURE AddNewRoute(
    p_Name VARCHAR,
    p_Start INT,
    p_End INT,
    p_DepartTime TIME,
    p_ArrivalTime TIME
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Route (Name, "Start", "End", DepartTime, ArrivalTime)
    VALUES (p_Name, p_Start, p_End, p_DepartTime, p_ArrivalTime);
END;
$$;

--menuvanje na arrival i depart time

CREATE PROCEDURE UpdateRouteTiming(
    p_RouteID INT,
    p_DepartTime TIME,
    p_ArrivalTime TIME
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Route
    SET DepartTime = p_DepartTime,
        ArrivalTime = p_ArrivalTime
    WHERE ID = p_RouteID;
END;
$$;


--dodavanje novi stanici

CREATE PROCEDURE AddNewStation(
    p_LocationID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Station (LocationID)
    VALUES (p_LocationID);
END;
$$;


--ruta na kompanija

CREATE PROCEDURE AssignCompanyToRoute(
    p_RouteID INT,
    p_CompanyID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Route_Company (RouteID, CompanyID)
    VALUES (p_RouteID, p_CompanyID);
END;
$$;


--dodavanje adresi za kompanii

CREATE OR REPLACE PROCEDURE AddAddressForCompany(
    p_CountryID INT,
    p_Street VARCHAR,
    p_Number INT,
    p_CompanyID INT,
    p_AdditionalInfo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Address (CountryID, Street, Number, CompanyID, AdditionalInfo)
    VALUES (p_CountryID, p_Street, p_Number, p_CompanyID, p_AdditionalInfo);
END;
$$;

--detalno za ruti

CREATE FUNCTION GetRouteDetails(p_RouteID INT)
RETURNS TABLE (
    RouteName VARCHAR,
    StartStation VARCHAR,
    EndStation VARCHAR,
    DepartTime TIME,
    ArrivalTime TIME,
    CompanyName VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT r.Name,
           s1.Name as StartStation,
           s2.Name as EndStation,
           r.DepartTime,
           r.ArrivalTime,
           c.Name as CompanyName
    FROM Route r
    JOIN Station s1 ON r."Start" = s1.ID
    JOIN Station s2 ON r."End" = s2.ID
    JOIN Route_Company rc ON r.ID = rc.RouteID
    JOIN Company c ON rc.CompanyID = c.ID
    WHERE r.ID = p_RouteID;
END;
$$;


-- brisenje na ruti

CREATE PROCEDURE DeleteRoute(
    p_RouteID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Route WHERE ID = p_RouteID;
END;
$$;

--dodavanje sekcii na ruta

CREATE PROCEDURE AddSectionToRoute(
    p_RouteID INT,
    p_StationID1 INT,
    p_StationID2 INT,
    p_Order INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Section (RouteID, StationID, StationID2, "order")
    VALUES (p_RouteID, p_StationID1, p_StationID2, p_Order);
END;
$$;




