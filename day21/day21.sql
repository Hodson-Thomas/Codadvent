DROP TABLE IF EXISTS missing;

CREATE TABLE missing AS SELECT * FROM transactions t
LEFT JOIN gift g
ON t.gift_id = g.gift_id
WHERE g.status = "missing" AND action = "transfer";


SELECT person_id, full_name, role FROM person p 
LEFT JOIN missing q
ON p.person_id = q.actor_id
WHERE q.details = "moved to secret shelf 🧝"
GROUP BY p.person_id