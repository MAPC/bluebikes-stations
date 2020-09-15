VPATH = data/finished
DIR = $(CURDIR)
export

.PHONY: all clean

all: current_bluebikes_stations.shp

clean:
	rm -R data/finished/*

current_bluebikes_stations.csv:
	curl -o data/finished/$(notdir $@) https://s3.amazonaws.com/hubway-data/current_bluebikes_stations.csv

current_bluebikes_stations.shp: current_bluebikes_stations.csv
	sed -i '' 1d data/finished/$(notdir $<)
	ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:4326\
		-oo X_POSSIBLE_NAMES=Longitude -oo Y_POSSIBLE_NAMES=Latitude\
		-f "ESRI Shapefile" data/finished/$(notdir $@) data/finished/$(notdir $<)
