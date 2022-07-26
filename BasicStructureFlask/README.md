# BASIC STUCTURE FLASK PROJECT
Basic structure for build a flask project with docker
```
docker build -t basicflask:1.0 .
```

Then we will run it, as shown in the following code:
```
docker run -p 5000:5000 basicflask
```

List all the running containers
```
docker container list
```