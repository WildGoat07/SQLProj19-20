/* question 7 */
SELECT DISTINCT
    q.no_question AS "Les questions auxquelles les utilisateurs n'ont jamais répondu lors de leurs différentes sessions"
FROM
    `question` AS q
WHERE
    q.no_question NOT IN(
    SELECT
        rd.no_question
    FROM
        `rep_donnee` AS rd
);

/* question 8 */
CREATE TABLE r1 AS SELECT
    COUNT(s.no_quest) AS s1
FROM
    `questionnaire` AS q,
    `quest_session` AS s,
    `theme` AS t
WHERE
    q.no_quest = s.no_quest AND q.no_theme = t.no_theme AND t.libelle_theme = "Sport" OR t.libelle_theme = "Bière" AND s.date_session LIKE "2019-09-%";
CREATE TABLE r2 AS SELECT
    COUNT(no_quest) AS s2
FROM
    `questionnaire`;
SELECT
    (s1 / s2) AS "Le pourcentage correspondant aux sessions de septembre 2019 portant sur le sport ou la bière"
FROM
    `r1`,
    `r2`;
DROP TABLE
    r1;
DROP TABLE
    r2;

    /* question 9 */
SELECT
    q.no_question AS "Les questions auxquelles COVER Harry n'a pas répondu lors de sa session 15"
FROM
    `question` AS q,
    `quest_session` AS s,
    `se_compose` AS sc
WHERE
    q.no_question AND q.no_question = sc.no_question AND sc.no_quest = s.no_quest AND s.no_session = "15" NOT IN(
    SELECT
        rd.no_question
    FROM
        `rep_donnee` AS rd,
        `quest_session` AS s,
        `personne` AS p
    WHERE
        s.no_session = rd.no_session AND s.no_pers = p.no_pers AND s.no_session = "15" AND p.nom_pers = "cover" AND p.prenom_pers = "harry"
)
ORDER BY
    q.no_question;

    /* question 10 */
CREATE TABLE r1 AS SELECT
    q.no_question
FROM
    `question` AS q,
    `rep_proposee` AS rp
WHERE
    q.no_question = rp.no_question AND rp.etat_rep = "1" AND rp.no_ordre = "1";
CREATE TABLE r2 AS SELECT
    q.no_question
FROM
    `question` AS q;
SELECT
    (s1 / s2) AS "Pourcentage des questions qui ont une réponse juste proposée en première position"
FROM
    `r1`,
    `r2`;
DROP TABLE
    r1;
DROP TABLE
    r2;

    /* question 11 */
SELECT
    rp.no_question AS "Les réponses enregistrées pour un utilisateur ne correspondent pas à une des propositions"
FROM
    `rep_proposee` AS rp,
    `rep_donnee` AS rd
WHERE
    rd.no_question <> rp.no_question AND rd.no_question = rp.no_question;

    /* question 12 */
SELECT
    q.no_question AS "Des questions ne comportant aucune bonne réponse"
FROM
    `question` AS q
WHERE
    q.no_question NOT IN(
    SELECT
        rp.no_question
    FROM
        `question` AS q,
        `rep_proposee` AS rp
    WHERE
        q.no_question = rp.no_question AND rp.etat_rep = "1"
);