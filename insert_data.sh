#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#while read $winner, $opponent 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 

#Insert teams in teams table 
  #check winners 
  CHECK_FOR_WINNERS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
  if [[ (-z $CHECK_FOR_CONTAINS_WINNER) && ($WINNER != "winner")]]
  then
    INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
  fi

  #check opponents 
  CHECK_FOR_CONTAINS_OPPONENT=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
  if [[ (-z $CHECK_FOR_CONTAINS_OPPONENT) && ($OPPONENT != "opponent")]]
  then
    INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
  fi

#Insert values into game table 

  #get Winner_id 
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  #getOpponent_id 
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  #Insert values 
  if [[ $ROUND != "round" ]]
  then
    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')")
  fi 

done  