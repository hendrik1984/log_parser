# Readme

# Description
project to parse log from apache and search based on filter define on system

# Step by step configure log parse project
1. Make sure you install docker first
2. Run this command building image first run this on your terminal: <b>docker-compose build</b>
3. For 1st time you need to configure database volume, run server up first with command <b>docker-compose up</b> and then open new terminal run 2 command to create and migrate database: <b>docker-compose run web rake db:create</b> wait until finish after that run again this command <b>docker-compose run web rake db:migrate</b>
4. You can restart / server down by using command <b>docker-compose down</b> and then server up again<b>docker-compose up</b> just to make sure that it will work perfectly on your side.
