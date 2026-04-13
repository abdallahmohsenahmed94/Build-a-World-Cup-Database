#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

while IFS="," read year round winner opponent winner_goals opponent_goals
  do
    if [[ $winner != 'winner' ]]
    then
      TEAMS=$($PSQL "INSERT INTO teams (name) VALUES ('$winner');")
      TEAMS=$($PSQL "INSERT INTO teams (name) VALUES ('$opponent');")
      winner_id=$($PSQL "SELECT team_id FROM teams where name='$winner';")
      opponent_id=$($PSQL "SELECT team_id FROM teams where name='$opponent';")
      GAMES=$($PSQL "INSERT INTO games (year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ('$year', '$round' , '$winner_id', '$opponent_id', '$winner_goals', '$opponent_goals');")
    fi
  done < games.csv