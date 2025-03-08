// Function to compute distance between two lat/lon points in km
// Example: Distance between San Francisco and Los Angeles
// haversine[37.7749; -122.4194; 34.0522; -118.2437]
atan2:{[y;x]
  $[x>0; atan y%x;
    x<0 & y>=0; atan y%x + acos -1;
    x<0 & y<0; atan y%x - acos -1;
    x=0 & y>0; acos 0;
    x=0 & y<0; neg acos 0;
    0N]  / Return null if x=y=0 (undefined case)
 };

haversine:{[lat1; lon1; lat2; lon2]
    R:6371; / Radius of Earth in km
    dlat:(lat2-lat1)*acos -1%180; / Convert degrees to radians
    dlon:(lon2-lon1)*acos -1%180;
    a:sin[dlat%2]*sin[dlat%2]+cos[lat1*acos -1%180]*cos[lat2*acos -1%180]*sin[dlon%2]*sin[dlon%2];
    c:2*atan2[sqrt a;sqrt[1-a]];
    R*c
 };

// The midpoint formula calculates the geographical center between two latitude-longitude points. This is useful for navigation and spatial analysis.
// midpoint[37.7749; -122.4194; 34.0522; -118.2437]  / SF to LA midpoint
midpoint:{[lat1; lon1; lat2; lon2]
    lat1:lat1*acos -1%180;  / Convert to radians
    lon1:lon1*acos -1%180;
    lat2:lat2*acos -1%180;
    lon2:lon2*acos -1%180;

    dlon: lon2 - lon1;
  
    B: cos[lat2] * cos[dlon];
    C: cos[lat2] * sin[dlon];

    latM: atan[(sin[lat1] + sin[lat2]) % sqrt[(cos[lat1] + B) * (cos[lat1] + B) + C * C]];
    lonM: lon1 + atan2[C; cos[lat1] + B];

    : (latM * 180 % acos -1; lonM * 180 % acos -1)  / Convert back to degrees
 };
