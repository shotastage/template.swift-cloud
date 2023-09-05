build:
	swift build

relase:
	swift build -c release

clean:
	swift package clean
	rm -rf .swiftpm/
	rm -rf .build/

remote-migrate:
	heroku run App -- migrate --env production
