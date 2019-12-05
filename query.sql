/* question 7 */
SELECT DISTINCT q.no_question
FROM question AS q
WHERE q.no_question NOT IN (
    SELECT rd.no_question
    FROM rep-donnee AS rd
    )
;

/* question 8 */
CREATE TEMPORARY TABLE AS r1
SELECT sc.no_quest AS s1
FROM question AS q, session AS s, theme AS table
WHERE q.no_quest=s.no_quest
    AND q.no_theme=t.no_theme
    AND t.libelle_theme="Sport"
    OR t.libelle_theme="Bière"
    AND s.date-session LIKE "2019-09-%"
;
CREATE TEMPORARY TABLE AS r2
SELECT no_quest AS s2
FROM questionnaire
;
SELECT (r1/r2) AS pourcentage
FROM r1, r2
;
DROP TABLE r1
;
DROP TABLE r2
;

/* question 9 */
SELECT ORDER BY (q.no_question)
FROM question AS q
WHERE q.no_question NOT IN(
    SELECT rd.no_question
    FROM rep-donnee AS rd, session AS s, personne AS p
    WHERE s.no_session=rd.no_session
        AND s.no_personne=p.no_personne
        AND s.no_session="15"
        AND p.nom_personne="COVER"
        AND p.prenom-personne="Henry"
    )
;