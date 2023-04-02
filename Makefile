postgres:
	docker run --name postgres12 -p 5433:5433 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank 

migrateup:
	migrate -path db/migration -database "postgresql://postgres:123@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:123@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	 docker run --rm -v "${pwd}:/src" -w /src kjconroy/sqlc generate


test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test