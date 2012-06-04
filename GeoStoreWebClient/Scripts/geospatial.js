// This file is copied from UCharge.Geospatial library written in C#.
// Please contact Jeff Wang (wangchj@auburn.edu or cjw39@hotmail.com) before
// using this script.
// Author: Jeff Wang
// Created: May 1, 2012

/// <summary>
/// The max distance in a degree of longitude in kilometers, which is at
/// the equator.
/// </summary>
var MaxDistLonDegKm = 111.321;

/// <summary>
/// Radius of the Earth in kilometers.
/// </summary>
var MeanEarthRadiusKm = 6371;

/// <summary>
/// Distance in a degree of latitude in kilometers.
/// </summary>
/// <remarks>This is the arc length on the surface of the Earth and is
/// calculated by (2 * pi) / 360 * RadiusOfEarth</remarks>
var MeanDistLatDegKm = 111.19;


/// <summary>Converts kilometers to latitude degrees.</summary>
/// <returns>latitude degrees.</returns>
/// <param name='km'>Kilometers</param>
function KmToLatDeg(km)
{
    return km / MeanDistLatDegKm;
}

/// <summary>Converts kilometer to longitude degree at a latitude.</summary>
/// <returns>Longitude degree</returns>
/// <param name='lat'>Latitude degree</param>
/// <param name='km'>Kilometers</param>
/// <exception cref="ArgumentException">If lat is greater than 90 or less
/// than -90.</exception>
function KmToLonDeg(latDeg, km)
{
    CheckLatBound(latDeg);
    return km / LonDegToKm(latDeg, 1);
}

/// <summary>Converts longitude degrees to kilometers.</summary>
/// <returns>Kilometers.</returns>
/// <param name='latDeg'>Latitude degree.</param>
/// <param name='lonDeg'>Longitude degree to be converted.</param>
/// <exception cref='ArgumentException'>When latitude or longitude
/// degrees are invalid.</exception>
function LonDegToKm(latDeg, lonDeg)
{
    CheckCoordinates(latDeg, lonDeg);
    return Math.Cos(DegreeToRadian(latDeg)) * MaxDistLonDegKm;
}

/// <summary>Throws exception if latitude or longitude is out of range.</summary>
/// <param name='lat'>Latitude degree.</param>
/// <param name='lon'>Longitude degree.</param>
/// <exception cref='ApplicationException'>
/// <see cref="T:System.ApplicationException" /></exception>
function CheckCoordinates(lat, lon)
{
    CheckLatBound(lat);
    CheckLonBound(lon);
}

/// <summary>Throws exception if latitude is out of range.</summary>
/// <param name='lat'>Latitude degree.</param>
/// <exception cref='ApplicationException'></exception>
function CheckLatBound(lat)
{
    if (lat < -90 || lat > 90)
        throw "Latitude is out of bound.";
}

/// <summary>Throws exception if longitude is out of range.</summary>
/// <param name='lat'>Latitude degree.</param>
/// <exception cref='ApplicationException'></exception>
function CheckLonBound(lon)
{
    if (lon < -180 || lon > 180)
        throw "Longitude is out of bound.";
}

/// <summary>Converts angular degrees to radian.</summary>
/// <returns>degree in radian.</returns>
/// <param name='degree'>Angular degree</param>
function DegreeToRadian (degree)
{
    return Math.PI * degree / 180;
}

