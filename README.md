<!---
______________________________________________________________________________

/!\
/!\
Un aperçu du markdown est disponible à cette adresse :
https://github.com/WildGoat07/SQLProj19-20/blob/master/README.md

______________________________________________________________________________
-->
# Projet SQL 2019 - 2020

Chaque requête est écrite de manière compatible (par rapport au cours et au design d'un arbre) et d'une manière plus conventionnelle (optimisation, lisibilité) mais utilise des élements non vus en cours.

## requêtes :

1. > *Quelle(s) est (sont) la (les) bonne(s) réponse(s) à la question q3?*

    #### conventionnelle :
    ```sql
    -- simple jonction entre deux tables
    SELECT rep_proposee.lib_reponse AS reponse
    FROM rep_proposee
    INNER JOIN question ON rep_proposee.no_question = question.no_question
    WHERE rep_proposee.etat_rep = true
    AND question.no_question = 3;
    ```
    #### compatible :
    ```sql
    -- simple jonction entre deux tables
    SELECT rep_proposee.lib_reponse AS reponse
    FROM rep_proposee, question
    WHERE rep_proposee.etat_rep = true
    AND question.no_question = 3
    AND rep_proposee.no_question = question.no_question;
    ```
1. > *La réponse donnée par Ric HOCHET à la question 4 lors de la session 12 est-elle juste ou fausse ?*

    > **Note sur le sens de la consigne :**
    >
    > La "question 4" fait référence à la quatrième question du questionnaire, et la "session 12" correspond à son identifiant (qui peut ne pas provenir de Ric HOCHET, auquel cas rien n'est présent dans la table sélectionnée)
    
    #### conventionnelle :
    ```sql
    -- jonctions multiples et des conditions
    SELECT question.libelle AS question, rep_proposee.lib_reponse AS reponse,
    CASE
        WHEN rep_proposee.etat_rep = true THEN "vrai"
        ELSE "faux"
    END AS etat
    FROM rep_proposee
    INNER JOIN question ON question.no_question = rep_proposee.no_question
    INNER JOIN rep_donnee ON rep_donnee.no_question = question.no_question
    AND rep_proposee.no_ordre = rep_donnee.no_ordre
    INNER JOIN quest_session ON rep_donnee.no_session = quest_session.no_session
    INNER JOIN personne ON quest_session.no_pers = personne.no_pers
    INNER JOIN se_compose ON se_compose.no_question = rep_proposee.no_question
    AND se_compose.no_quest = quest_session.no_quest
    WHERE quest_session.no_session = 12
    AND personne.nom_pers = LOWER("HOCHET")
    AND personne.prenom_pers = LOWER("Ric")
    -- on mets 3 car l'ordre des question commence à 0 et non 1, comme tout bon langage de programmation
    AND se_compose.no_ordre = 3;    
    ```
    #### compatible :
    ```sql
    -- jonctions multiples et des conditions
    SELECT question.libelle AS question, rep_proposee.lib_reponse AS reponse, rep_proposee.etat_rep AS etat
    FROM rep_proposee, question, rep_donnee, quest_session, personne, se_compose
    WHERE quest_session.no_session = 12
    AND personne.nom_pers = "hochet"
    AND personne.prenom_pers = "ric"
       -- on mets 3 car l'ordre des question commence à 0 et non 1, comme tout bon langage de programmation
    AND se_compose.no_ordre = 3
    AND question.no_question = rep_proposee.no_question
    AND rep_donnee.no_question = question.no_question
    AND rep_proposee.no_ordre = rep_donnee.no_ordre
    AND rep_donnee.no_session = quest_session.no_session
    AND quest_session.no_pers = personne.no_pers
    AND se_compose.no_quest = quest_session.no_quest
    AND se_compose.no_question = question.no_question;
    ```
1. > *Quel pourcentage des utilisateurs ont tenté plusieurs fois le même questionnaire ?*

    #### conventionnelle :
    ```sql
    -- on crée une table contenant une seule case (colonne 'c') donnant le nombre d’utilisateurs différents ayant lancé minimum 2 fois un même questionnaire
    CREATE TABLE quest_started AS
    SELECT COUNT(DISTINCT quest_session.no_pers) AS c
    FROM quest_session
    GROUP BY quest_session.no_pers, quest_session.no_quest
    HAVING COUNT(quest_session.no_quest) >= 2;
    -- on crée une table qui contient une seule case (colonne 'c') qui indique le nombre total d'utilisateurs
    CREATE TABLE user_count AS
    SELECT COUNT(*) AS c
    FROM personne;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT quest_started.c/user_count.c pourcentage
    FROM quest_started, user_count;
    -- on se débarrasse des tables temporaires
    DROP TABLE quest_started;
    DROP TABLE user_count;
    ```
    #### compatible :
    ```sql
    -- on crée une table qui contient une seule case (colonne 'c') contenant le nombre d'utilisateurs ayant démarré un même questionnaire plusieurs fois
    CREATE TABLE quest_started AS
    SELECT COUNT(DISTINCT qs1.no_pers) c
    FROM quest_session AS qs1, quest_session AS qs2
    WHERE qs1.no_pers = qs2.no_pers
    AND qs1.no_quest <> qs2.no_quest;
    -- on crée une table qui contient une seule case (colonne 'c') qui indique le nombre total d'utilisateurs
    CREATE TABLE user_count AS
    SELECT COUNT(*) c
    FROM personne;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT quest_started.c/user_count.c percent
    FROM quest_started, user_count;
    -- on se débarrasse des tables temporaires
    DROP TABLE quest_started;
    DROP TABLE user_count;
    ```
1. > *Donner, classées par date de session décroissante et par ordre alphabétique, les personnes qui ont répondu en 2018 à des questionnaires sur le sport*

    #### conventionnelle :
    ```sql
    -- jointures et tri
    SELECT personne.nom_pers AS nom, personne.prenom_pers AS prenom, quest_session.date_session AS "date"
    FROM personne
    INNER JOIN quest_session ON quest_session.no_pers = personne.no_pers
    INNER JOIN questionnaire ON quest_session.no_quest = questionnaire.no_quest
    INNER JOIN theme ON questionnaire.no_theme = theme.no_theme
    WHERE theme.libelle_theme = "sport"
    AND YEAR(quest_session.date_session) = 2018
    ORDER BY quest_session.date_session DESC, personne.nom_pers, personne.prenom_pers;
    ```
    #### compatible :
    ```sql
    -- jointures et tri
    SELECT personne.nom_pers AS nom, personne.prenom_pers AS prenom, quest_session.date_session AS "date"
    FROM personne, quest_session, questionnaire, theme
    WHERE personne.no_pers = quest_session.no_pers
    AND questionnaire.no_quest = quest_session.no_quest
    AND theme.no_theme = questionnaire.no_theme
    AND theme.libelle_theme = "sport"
    AND quest_session.date_session LIKE "2018-%"
    ORDER BY quest_session.date_session DESC, personne.nom_pers, personne.prenom_pers;
    ```
1. > *Quel est le pourcentage de réponses correctes à la question q2?*

    #### conventionnelle :
    ```sql
    -- on créé une table qui contient le nombre de réponses justes
    CREATE TABLE correct_count AS
    SELECT COUNT(*) AS c
    FROM rep_donnee
    INNER JOIN question ON question.no_question = rep_donnee.no_question
    INNER JOIN rep_proposee ON rep_proposee.no_question = rep_donnee.no_question
    AND rep_proposee.no_ordre = rep_donnee.no_ordre
    WHERE rep_proposee.etat_rep = true
    AND question.no_question = 2;
    -- on créé une table qui contient le nombre de réponses total
    CREATE TABLE answer_count AS
    SELECT COUNT(*) AS c
    FROM rep_donnee
    INNER JOIN question ON question.no_question = rep_donnee.no_question
    WHERE question.no_question = 2;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT correct_count.c/answer_count.c AS pourcentage
    FROM correct_count, answer_count;
    DROP TABLE correct_count;
    DROP TABLE answer_count;
    ```
    #### compatible :
    ```sql
    -- on créé une table qui contient le nombre de réponses justes
    CREATE TABLE correct_count AS
    SELECT COUNT(*) AS c
    FROM rep_donnee, question, rep_donnee
    WHERE rep_proposee.etat_rep = true
    AND question.no_question = 2
    AND question.no_question = rep_donnee.no_question
    AND rep_proposee.no_question = rep_donnee.no_question
    AND rep_proposee.no_ordre = rep_donnee.no_ordre;
    -- on créé une table qui contient le nombre de réponses total
    CREATE TABLE answer_count AS
    SELECT COUNT(*) AS c
    FROM rep_donnee, question
    WHERE question.no_question = 2
    AND question.no_question = rep_donnee.no_question;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT correct_count.c/answer_count.c AS pourcentage
    FROM correct_count, answer_count;
    DROP TABLE correct_count;
    DROP TABLE answer_count;
    ```
