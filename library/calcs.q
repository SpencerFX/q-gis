// Function to compute distance between two lat/lon points in km
// Example: Distance between San Francisco and Los Angeles
// haversine[37.7749; -122.4194; 34.0522; -118.2437]
haversine:{[lat1; lon1; lat2; lon2]
  R:6371; / Radius of Earth in km
    dlat:(lat2-lat1)*acos -1%180; / Convert degrees to radians
    dlon:(lon2-lon1)*acos -1%180;
    a:sin[dlat%2]*sin[dlat%2]+cos[lat1*acos -1%180]*cos[lat2*acos -1%180]*sin[dlon%2]*sin[dlon%2];
    c:2*atan2[sqrt a;sqrt[1-a]];
    R*c
 };
