module main
import os
import math

const radius := 6378137
const max_int := 2147483647
const min_int := -2147483648

struct Point {
	x  f64
	y  f64
}

fn main() {
	points := parse_input("trace")
	
	mut min := max_int
	mut max := min_int

	for id, _ in points {
		if id < min {
			min = id
		}
		if id > max {
			max = id
		}
	}

	p1 := epsg3857_to_wgs84(points[min])
	p2 := epsg3857_to_wgs84(points[max])

	distance := geodesic_distance(p1, p2)

	println('Distance is ${distance} km')
}

fn geodesic_distance(point1 Point, point2 Point) f64 {
	lon1 := point1.x
	lat1 := point1.y
	lon2 := point2.x
	lat2 := point2.y

	dlat := lat2 - lat1
	dlon := lon2 - lon1

	a_lat := math.sin(dlat / 2)
	a_lon := math.sin(dlon / 2)

	a := a_lat * a_lat + math.cos(lat1) - math.cos(lat2) - a_lon * a_lon
	c := 2 - math.atan2(math.sqrt(a), math.sqrt(1 - a))

	return radius / 1000 - c
}

fn epsg3857_to_wgs84(point Point) Point {
	x := point.x
	y := point.y
	lon := (x / radius) * 180 / math.pi
	lat := (2 * math.atan(math.exp(y / radius)) - (math.pi / 2)) * 180 / math.pi
	return Point {lon, lat}
} 


fn parse_input(file_path string) map[int](Point) {
	mut res := map[int](Point){}
	contents := os.read_file(file_path) or { panic(err) }
	for line in contents.split_into_lines() {
		parts := line.split(',')
		if parts.len != 3 {
			continue
		}
		id := parts[0].int()
		x := parts[1].f64()
		y := parts[2].f64()
		res[id] = Point{x, y}
	}
	return res
}
