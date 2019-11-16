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
    select lib_reponse
    from rep_proposee
    inner join question on rep_proposee.no_question = question.no_question
    where etat_rep = true
    and question.no_question = 3;
    ```
    #### compatible :
    ```sql
    -- simple jonction entre deux tables
    select lib_reponse
    from rep_proposee, question
    where etat_rep = true
    and question.no_question = 3
    and rep_proposee.no_question = question.no_question;
    ```
1. > *La réponse donnée par Ric HOCHET à la question 4 lors de la session 12 est-elle juste ou fausse ?*

    > **Note sur le sens de la consigne :**
    >
    > La "question 4" référence à la quatrième question du questionnaire, et la "session 12" correspond à son identifiant (qui peut ne pas provenir de Ric HOCHET, auquel cas rien n'est présent dans la table sélectionnée)
    
    #### conventionnelle :
    ```sql
    -- jonctions multiples et des conditions
    select libelle, lib_reponse,
    case
        when etat_rep = true then "vrai"
        else "faux"
    end as etat_rep
    from rep_proposee
    inner join question on question.no_question = rep_proposee.no_question
    inner join rep_donnee on rep_donnee.no_question = question.no_question
    and rep_proposee.no_ordre = rep_donnee.no_ordre
    inner join quest_session on rep_donnee.no_session = quest_session.no_session
    inner join personne on quest_session.no_pers = personne.no_pers
    inner join se_compose on se_compose.no_question = rep_proposee.no_question
    and se_compose.no_quest = quest_session.no_quest
    where quest_session.no_session = 12
    and nom_pers = lower("HOCHET")
    and prenom_pers = lower("Ric")
    -- on mets 3 car l'ordre des question commence à 0 et non 1, comme tout bon langage de programmation
    and se_compose.no_ordre = 3;    
    ```
    #### compatible :
    ```sql
    -- jonctions multiples et des conditions
    select libelle, lib_reponse, etat_rep
    from rep_proposee, question, rep_donnee, quest_session, personne, se_compose
    where quest_session.no_session = 12
    and nom_pers = "hochet"
    and prenom_pers = "ric"
       -- on mets 3 car l'ordre des question commence à 0 et non 1, comme tout bon langage de programmation
    and se_compose.no_ordre = 3
    and question.no_question = rep_proposee.no_question
    and rep_donnee.no_question = question.no_question
    and rep_proposee.no_ordre = rep_donnee.no_ordre
    and rep_donnee.no_session = quest_session.no_session
    and quest_session.no_pers = personne.no_pers
    and se_compose.no_quest = quest_session.no_quest
    and se_compose.no_question = question.no_question;
    ```
1. > *Quel pourcentage des utilisateurs ont tenté plusieurs fois le même questionnaire ?*

    #### conventionnelle :
    ```sql
    -- on crée une table contenant une seule case (colonne 'c') donnant le nombre d’utilisateurs différents ayant lancé minimum 2 fois un même questionnaire
    create table quest_started as
    select count(distinct no_pers) as c
    from quest_session
    group by no_pers, no_quest
    having count(no_quest) >= 2;
    -- on crée une table qui contient une seule case (colonne 'c') qui indique le nombre total d'utilisateurs
    create table user_count as
    select count(*) as c
    from personne;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    select quest_started.c/user_count.c pourcentage
    from quest_started, user_count;
    -- on se débarrasse des tables temporaires
    drop table quest_started;
    drop table user_count;
    ```
    #### compatible :
    ```sql
    -- on crée une table qui contient une seule case (colonne 'c') contenant le nombre d'utilisateurs ayant démarré un même questionnaire plusieurs fois
    create table quest_started as
    select count(distinct qs1.no_pers) c
    from quest_session qs1, quest_session qs2
    where qs1.no_pers = qs2.no_pers
    and qs1.no_quest <> qs2.no_quest;
    -- on crée une table qui contient une seule case (colonne 'c') qui indique le nombre total d'utilisateurs
    create table user_count as
    select count(*) c
    from personne;
    -- on renvoie le pourcentage (et on ne multiplie PAS un pourcentage par 100, c’est au programme/site appelant de le faire pour le formattage !!!)
    select quest_started.c/user_count.c percent
    from quest_started, user_count;
    -- on se débarrasse des tables temporaires
    drop table quest_started;
    drop table user_count;
    ```
1. > *Donner, classées par date de session décroissante et par ordre alphabétique, les personnes qui ont répondu en 2018 à des questionnaires sur le sport*

    #### conventionnelle :
    ```sql
    -- jointures et tri
    select nom_pers, prenom_pers, date_session
    from personne
    inner join quest_session on quest_session.no_pers = personne.no_pers
    inner join questionnaire on quest_session.no_quest = questionnaire.no_quest
    inner join theme on questionnaire.no_theme = theme.no_theme
    where theme.libelle_theme = "sport"
    and year(date_session) = 2018
    order by date_session desc, nom_pers, prenom_pers;
    ```
    #### compatible :
    ```sql
    -- jointures et tri
    select nom_pers, prenom_pers, date_session
    from personne, quest_session, questionnaire, theme
    where personne.no_pers = quest_session.no_pers
    and questionnaire.no_quest = quest_session.no_quest
    and theme.no_theme = questionnaire.no_theme
    and theme.libelle_theme = "sport"
    and year(date_session) = 2018
    order by date_session desc, nom_pers, prenom_pers;
    ```
