import sqlite3
import folium
from pyproj import Transformer
import webbrowser

DATABASE: str = "kids.db"
LIMIT = 3
YEAR = 2025


conn =  sqlite3.connect(DATABASE)
top_behaving_children = [cursor[0] for cursor in conn.execute("SELECT child_id FROM behavior WHERE YEAR = ? ORDER BY nice_score DESC LIMIT ?", (YEAR, LIMIT))]

children =  []
for child_id in top_behaving_children:
    details = conn.execute("SELECT first_name, last_name, birthdate, household_id FROM children WHERE id = ?", (child_id, )).fetchone()
    address = conn.execute("SELECT address, city_id FROM households WHERE id = ?", (details[3],)).fetchone()
    city = conn.execute("SELECT name, country_code FROM cities WHERE id = ?", (address[1],)).fetchone()
    country = conn.execute("SELECT name FROM countries WHERE code = ?", (city[1],)).fetchone()
    coordinates = conn.execute("SELECT x_m, y_m FROM elf_plan WHERE child_id = ?", (child_id,)).fetchone()

    children.append({
        "firstname": details[0],
        "lastname": details[1],
        "birthdate": details[2],
        "address" : address[0],
        "city": city[0],
        "country": country[0],
        "x_m": coordinates[0],
        "y_m": coordinates[1]
    })

print("2025's top children are :")

transformer = Transformer.from_crs("EPSG:3857", "EPSG:4326", always_xy=True)
markers = []

for child in children:
    print(f" - {child["firstname"]} {child["lastname"]}, born the {child["birthdate"]}, located at {child["address"]}, {child["city"]}, {child["country"]}")
    y, x = transformer.transform(child["x_m"], child["y_m"])
    markers.append((x, y, f"{child["firstname"]} {child["lastname"]}"))

center_x = sum(m[0] for m in markers) / len(markers)
center_y = sum(m[1] for m in markers) / len(markers)

m = folium.Map(
    location=[center_x, center_y],
    zoom_start=0,
    tiles="OpenStreetMap"
)

for lat, lon, name in markers:
    popup_text = f"<b>{name}</b>"
    
    folium.Marker(
        location=[lat, lon],
        popup=folium.Popup(popup_text, max_width=300),
        tooltip=name,
        icon=folium.Icon(color="blue", icon="info-sign")
    ).add_to(m)

m.save("positions.html")
webbrowser.open("positions.html")
