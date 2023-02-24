-- CREATE TABLE personal_projects.gks_22_countBy_country  (Country text, embassy_track int, university_track int, research_track int, uic_track int, total int)
	
	WITH dummies AS (
		WITH CONTEOS AS (SELECT 
			Country,
			Application_Track,
			count(*) as conteo
		FROM personal_projects.gks_22_results
		-- WHERE Country IN ('Vietnam', 'Mexico','Indonesia','France','India')
		GROUP BY 1,2
		ORDER BY 1) 
			SELECT 
				*,
				IF (Application_Track = 'Embassy' , conteo, 0) as embassy_track,
				IF (Application_Track = 'University' , conteo, 0) as university_track,
				IF (Application_Track = 'R&D' , conteo, 0) as research_track,
				IF (Application_Track = 'UIC' , conteo, 0) as uic_track,
				sum(conteo) as suma
			FROM CONTEOS
			group by 1,2,3,4,5,6,7
			order by 1 )
		SELECT Country, 
				max(embassy_track) as embassy_track, 
				max(university_track) as university_track, 
				max(research_track) as research_track, 
				max(uic_track) as uic_track,
				(max(embassy_track) + max(university_track) + max(research_track) + max(uic_track)) as total 
		FROM dummies
		group by 1
		order by 1 asc;
