#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

SERVICE_LIST(){
  SERVICES_LIST=$($PSQL "SELECT service_id, name FROM services")
  echo "$SERVICES_LIST" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
      echo "$SERVICE_ID) $SERVICE_NAME "
  done

  echo -e "\nSelected service: "
  read SERVICE_ID_SELECTED

  SELECTED_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED") 
  if [[ -z $SELECTED_SERVICE ]]
    then SERVICE_LIST
  else
    echo -e "\nPhone number: "
    read CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'") 
    if [[ -z $CUSTOMER_ID ]]
      then 
          echo -e "\nCustomer name: "
          read CUSTOMER_NAME
          $INSERTED_CUSTOMER = $($PSQL "INSERT INTO customers(phone, name) VALUES( '$CUSTOMER_PHONE', '$CUSTOMER_NAME' )" )
    else
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE CUSTOMER_ID=$CUSTOMER_ID") 
    fi

    echo -e "\nService time: "
    read SERVICE_TIME
    $INSERTED_APPOINTMENT = $($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME' )" )
    echo -e "\nI have put you down for a $SELECTED_SERVICE at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  fi
}

SERVICE_LIST


