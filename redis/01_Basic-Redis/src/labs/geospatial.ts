import redisClient from "@/client";

const init = async () => {
  /*
  // geoadd(key, longitude, latitude, memberName)
  const geoAdd = await redisClient.geoadd(
    "locations",
    13.361389,
    38.115556,
    "Palermo",
  );
  console.log("geoAdd result =>", geoAdd);

  // add multiple entry
  const geoMultiAdd = await redisClient.geoadd(
    "locations",
    15.087269,
    37.502669,
    "Catania",
    13.583333,
    37.316667,
    "Agrigento",
  );
  console.log("geoMultiAdd result=>", geoMultiAdd);
*/

  // GEOSEARCH: find places within 200 km of Palermo
  type GeoSearchResult = [string, string, [string, string]];

  const results = (await redisClient.geosearch(
    "locations",
    "FROMLONLAT",
    13.361389,
    38.115556,
    "BYRADIUS",
    200,
    "km",
    "WITHDIST",
    "WITHCOORD",
  )) as GeoSearchResult[];

  const formatted = results.map(([name, distance, [lon, lat]]) => ({
    location: name,
    distanceKm: Number(distance).toFixed(2),
    longitude: Number(lon),
    latitude: Number(lat),
  }));

  console.log("Nearby locations:");

  formatted.forEach((loc, i) => {
    console.log(
      `${i + 1}. ${loc.location} — ${loc.distanceKm} km away (lon: ${loc.longitude}, lat: ${loc.latitude})`,
    );
  });
};

init();
