<!---
______________________________________________________________________________

/!\
/!\
Un aperçu du markdown est disponible à cette adresse :
https://github.com/WildGoat07/SQLProj19-20/blob/master/README.md

______________________________________________________________________________
-->
# Projet SQL 2019 - 2020

Chaque requête est écrite de manière compatible (par rapport au cours et au design d'un arbre) et d'une manière plus conventionnelle (optimisation, lisibilité) mais utilise des élements non vus en cours (dans la limite de nos connaissances personnelles).

## requêtes :

1. > *Quelle(s) est (sont) la (les) bonne(s) réponse(s) à la question q3?*

    #### conventionnelle :
    ```sql
    -- simple jonction entre deux tables
    SELECT
        rep_proposee.lib_reponse AS reponse
    FROM
        rep_proposee
        NATURAL JOIN question
    WHERE
        rep_proposee.etat_rep = TRUE
        AND question.no_question = 3;
    ```
    #### compatible :
    ```sql
    -- simple jonction entre deux tables
    SELECT
        rep_proposee.lib_reponse AS reponse
    FROM
        rep_proposee,
        question
    WHERE
        rep_proposee.etat_rep = TRUE
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
    SELECT
        question.libelle AS question,
        rep_proposee.lib_reponse AS reponse,
        CASE WHEN rep_proposee.etat_rep = TRUE THEN "vrai" ELSE "faux"
    END AS etat
    FROM
        rep_proposee
        NATURAL JOIN question
        NATURAL JOIN rep_donnee
        NATURAL JOIN quest_session
        NATURAL JOIN personne
        -- on mets un INNER JOIN car no_ordre est déjà présent dans la table actuelle, mais ne désigne pas la même chose
        INNER JOIN se_compose USING(no_question, no_quest)
    WHERE
        quest_session.no_session = 12
        AND LOWER(personne.nom_pers) = LOWER("HOCHET")
        AND LOWER(personne.prenom_pers) = LOWER("Ric")
        -- on mets 3 car l'ordre des question commence à 0 et non 1, comme tout bon langage de programmation
        AND se_compose.no_ordre = 3;
    ```
    #### compatible :
    ```sql
    -- jonctions multiples et des conditions
    SELECT
        question.libelle AS question,
        rep_proposee.lib_reponse AS reponse,
        rep_proposee.etat_rep AS etat
    FROM
        rep_proposee,
        question,
        rep_donnee,
        quest_session,
        personne,
        se_compose
    WHERE
        quest_session.no_session = 12
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
    SELECT
        -- on renvoie le pourcentage (et on ne multiplie pas un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage)
        (
            COUNT(*) /
            -- on créé une table contenant le nombre de personnes
            (
        SELECT
            COUNT(*)
        FROM
            personne
        )
        ) AS pourcentage
    FROM
        (
        -- on créé une table contenant les uniques personnes ayant lancé plusieurs fois un même questionnaire
        SELECT
            DISTINCT quest_session.no_pers
        FROM
            quest_session
            -- on les regroupe par personne, pour éviter les doublons dû aux plusieurs sessions lancées, puis par questionnaire
        GROUP BY
            quest_session.no_pers,
            quest_session.no_quest
            -- on choisi uniquement les utilisateurs ayant lancé 2 fois ou plus
        HAVING
            COUNT(quest_session.no_quest) >= 2
    ) AS c;
    ```
    #### compatible :
    ```sql
    -- on crée une table qui contient une seule case (colonne 'c') contenant le nombre d'utilisateurs ayant démarré un même questionnaire plusieurs fois
    CREATE TABLE quest_started AS SELECT
        COUNT(DISTINCT qs1.no_pers) AS c
    FROM
        quest_session AS qs1,
        quest_session AS qs2
    WHERE
        qs1.no_pers = qs2.no_pers
        AND qs1.no_session <> qs2.no_session
        AND qs1.no_quest = qs2.no_quest;
        -- on crée une table qui contient une seule case (colonne 'c') qui indique le nombre total d'utilisateurs
    CREATE TABLE user_count AS SELECT
        COUNT(*) AS c
    FROM
        personne;
        -- on renvoie le pourcentage (et on ne multiplie pas un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage)
    SELECT
        quest_started.c / user_count.c AS pourcentage
    FROM
        quest_started,
        user_count;
        -- on se débarrasse des tables temporaires
    DROP TABLE
        quest_started;
    DROP TABLE
        user_count;
    ```
1. > *Donner, classées par date de session décroissante et par ordre alphabétique, les personnes qui ont répondu en 2018 à des questionnaires sur le sport*

    #### conventionnelle :
    ```sql
    -- jointures et tri
    SELECT
        personne.nom_pers AS nom,
        personne.prenom_pers AS prenom,
        quest_session.date_session AS "date"
    FROM
        personne
    NATURAL JOIN quest_session
    NATURAL JOIN questionnaire
    NATURAL JOIN theme
    WHERE
        LOWER(theme.libelle_theme) = LOWER("sport")
        AND YEAR(quest_session.date_session) = 2018
    ORDER BY
        quest_session.date_session DESC,
        personne.nom_pers,
        personne.prenom_pers;
    ```
    #### compatible :
    ```sql
    -- jointures et tri
    SELECT
        personne.nom_pers AS nom,
        personne.prenom_pers AS prenom,
        quest_session.date_session AS "date"
    FROM
        personne,
        quest_session,
        questionnaire,
        theme
    WHERE
        personne.no_pers = quest_session.no_pers
        AND questionnaire.no_quest = quest_session.no_quest
        AND theme.no_theme = questionnaire.no_theme
        AND theme.libelle_theme = "Sport"
        AND quest_session.date_session LIKE "2018-%"
    ORDER BY
        quest_session.date_session DESC,
        personne.nom_pers,
        personne.prenom_pers;
    ```
1. > *Quel est le pourcentage de réponses correctes à la question q2?*

    > **Note sur le sens de la consigne :**
    >
    > On compte le nombre de réponses *données* par les utilisateurs et non celles *proposées* par le questionnaire, sinon il faudra simplifier la commande

    #### conventionnelle :
    ```sql
    SELECT
        (
            COUNT(rep_proposee.etat_rep) /
            -- on créé une table contenant le nombre de réponses données pour la question 2
            (
            SELECT
                COUNT(*)
            FROM
                rep_donnee
            WHERE
                rep_donnee.no_question = 2
            )
        ) AS pourcentage
    FROM
        rep_donnee
    NATURAL JOIN rep_proposee
    WHERE
        -- on prend uniquement les réponses justes
        rep_proposee.etat_rep = TRUE
        -- et de la question 2
        AND rep_proposee.no_question = 2;
    ```
    #### compatible :
    ```sql
    -- on créé une table qui contient le nombre de réponses justes
    CREATE TABLE correct_count AS SELECT
        COUNT(*) AS c
    FROM
        rep_donnee,
        rep_proposee
    WHERE
        rep_proposee.etat_rep = TRUE
        AND rep_donnee.no_question = 2
        AND rep_proposee.no_question = rep_donnee.no_question
        AND rep_proposee.no_ordre = rep_donnee.no_ordre;
        -- on créé une table qui contient le nombre de réponses total
    CREATE TABLE answer_count AS SELECT
        COUNT(*) AS c
    FROM
        rep_donnee
    WHERE
        rep_donnee.no_question = 2;
        -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT
        correct_count.c / answer_count.c AS pourcentage
    FROM
        correct_count,
        answer_count;
    DROP TABLE
        correct_count;
    DROP TABLE
        answer_count;
    ```
1. > *Quel est le pourcentage de non-réponses à la question q2?*

    #### conventionnelle :
    ```sql
    -- on créé une table qui contient, pour chaque session, sa réponse associée
        -- on se servira du fait que COUNT() ne prenne pas en compte les NULL pour compter les non-réponses
        -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT
        1 -(
            COUNT(rep_donnee.no_session) / COUNT(quest_session.no_session)
        ) AS pourcentage
    FROM
        quest_session
    NATURAL LEFT JOIN rep_donnee
        -- dans cet exemple : uniquement compatible avec MySQL, utiliser :
        -- ISNULL(rep_donnee.no_question, 2) avec SQL Server,
        -- IIF(IsNull(rep_donnee.no_question), 2, rep_donnee.no_question) avec MS Access
        -- ou NVL(rep_donnee.no_question, 2) avec Oracle.
        -- Comme on veut inclure les réponses "absentes", il faut inclure les NULL avec
    WHERE
        IFNULL(rep_donnee.no_question, 2) = 2;
    ```
    #### compatible :
    ```sql
    -- on commence par créer une table comptant le nombre de sessions contenant la question... EN QUESTION :DDD *badum tsss*
    CREATE TABLE question_instances_count SELECT
        COUNT(*) AS c
    FROM
        quest_session,
        se_compose
    WHERE
        se_compose.no_quest = quest_session.no_quest
        AND se_compose.no_question = 2;
        -- puis on créé une table comptant le nombre de réponses à cette question
    CREATE TABLE answers_count SELECT
        COUNT(*) AS c
    FROM
        rep_donnee
    WHERE
        rep_donnee.no_question = 2;
        -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    SELECT
        1 - (answers_count.c / question_instances_count.c) AS pourcentage
    FROM
        answers_count,
        question_instances_count;
    DROP TABLE
        question_instances_count;
    DROP TABLE
        answers_count;
    ```
1. > *Quelles sont les questions auxquelles les utilisateurs n’ont jamais répondu lors de leurs différentes sessions ?*

    ```sql
    SELECT DISTINCT
        question.no_question AS id,
        question.libelle AS question
        -- on prend toutes les question qui existent
    FROM
        question
    WHERE
        question.no_question NOT IN(
            -- on vérifie qu'elles ne soient pas dans celles répondues
        SELECT
            rep_donnee.no_question
        FROM
            rep_donnee
        );
    ```
1. > *Quel pourcentage des questionnaires correspondant aux sessions de septembre 2019 porte sur le sport ou la bière ?*

    #### conventionnelle :
    ```sql
    SELECT
        COUNT(DISTINCT questionnaire.no_quest) /
        (
            SELECT
                COUNT(DISTINCT questionnaire.no_quest)
            FROM
                questionnaire
                NATURAL JOIN quest_session
            WHERE
                YEAR(quest_session.date_session) = 2019
                AND MONTH(quest_session.date_session) = 9
        ) AS pourcentage
    FROM
        questionnaire
        NATURAL JOIN quest_session
        NATURAL JOIN theme
    WHERE
        YEAR(quest_session.date_session) = 2019
        AND MONTH(quest_session.date_session) = 9
        AND
        (
            LOWER(theme.libelle_theme) = LOWER("Sport")
            OR LOWER(theme.libelle_theme) = LOWER("Bière")
        )
    ```
    #### compatible :
    ```sql
    CREATE TABLE r1 AS
        SELECT s.no_quest AS s1
        FROM `questionnaire` AS q, `quest_session` AS s, `theme` AS t
        WHERE q.no_quest=s.no_quest
            AND q.no_theme=t.no_theme
            AND t.libelle_theme="Sport"
            OR t.libelle_theme="Bière"
            AND s.date_session LIKE "2019-09-%";
    CREATE TABLE r2 AS
        SELECT no_quest AS s2
        FROM `questionnaire`;
    SELECT (s1/s2) AS "Le pourcentage correspondant aux sessions de septembre 2019 portant sur le sport ou la bière"
    FROM `r1`, `r2`;
    DROP TABLE r1;
    DROP TABLE r2;
    ```

