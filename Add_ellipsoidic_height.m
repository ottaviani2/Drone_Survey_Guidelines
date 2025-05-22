[A,R] = readgeoraster("YOUR DTM PATH","OutputType","double");
%%
latlim = R.LatitudeLimits;
lonlim = R.LongitudeLimits;
%%
lat_step = (R.LatitudeLimits(2)-R.LatitudeLimits(1))./(R.RasterSize(1)-1);
lon_step = (R.LongitudeLimits(2)-R.LongitudeLimits(1))./(R.RasterSize(2)-1);
lat = R.LatitudeLimits(1)+1./2*lat_step:lat_step:R.LatitudeLimits(2)+1./2*lat_step;
lon = R.LongitudeLimits(1)+1./2*lon_step:lon_step:R.LongitudeLimits(2)+1./2*lon_step;
lat = flip(lat);

%%
h = zeros(R.RasterSize(1),R.RasterSize(2));
%LAT = zeros(1,R.RasterSize(1).*R.RasterSize(2));
%LON = zeros(1,R.RasterSize(1).*R.RasterSize(2));
%HEIGHT = zeros(1,R.RasterSize(1).*R.RasterSize(2));
%%
n=0;
for i = 1:R.RasterSize(1)
    for j = 1:R.RasterSize(2)
        N = egm96geoid(lat(i),lon(j));
        %n=n+1;
        %LAT(n)=lat(i);
        %LON(n)=lon(j);
        if A(i,j)<=-9999
            h(i,j)=-9999;
        else
            h(i,j) = A(i,j) + N;
        end
        %HEIGHT(n) = h(i,j);
    end
end

%%
geotiffwrite("YOUR OUTPUT PATH",h,R);
