fart='psql:postgresql/iso-3166.sql:3: ERROR: syntax error at or near "bomb" LINE 1: BEGIN bomb here ^ CREATE TABLE COPY 242 CREATE TABLE COPY 3995 COMMIT ANALYZE ANALYZE'

if [[ "$fart" == *ERROR:\ syntax\ error* ]]; then
  echo SHITBAT
fi