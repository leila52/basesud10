select e.id as id_entrenador, e.mentor as id_mentor, 
       j.nombre as nombre_jugador
from entrenadores e
join entrena en on e.id = en.id
join jugadores j on en.dorsal = j.dorsal;



+---------------+-----------+----------------+
| id_entrenador | id_mentor | nombre_jugador |
+---------------+-----------+----------------+
|             1 |      NULL | luca           |
|             2 |         1 | Jorge          |
|             3 |         1 | Marcos         |
|             5 |         2 | Jorge          |
|             4 |         3 | Martin         |
|             6 |         5 | Fernando       |
+---------------+-----------+----------------+