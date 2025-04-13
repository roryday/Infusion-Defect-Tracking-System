WITH asb_data AS (
    SELECT 
        pldo_nm,
        asy_eqp_nm,
        wk_end_dtms,
        eqp_nm,
        jero_id,
        isp_cell_id,
        dfct_cd
    FROM ensj_mfg_m_tb_mpprb_njma061_crcr_asy_prdn_h 
    WHERE proc_nm = 'Assembly'
        AND (wk_end_dtms >= ?E::date-2 AND wk_end_dtms < ?E::date+1)
        AND LEFT(asy_eqp_nm, 3) = 'CEF'
        AND dfct_cd<>'5'
),
wnd_data AS (
    SELECT 
        proc_nm,
        wk_end_dtms,
        eqp_nm,
        wind_id,
        jero_id
    FROM ensj_mfg_m_tb_mpprb_njma061_crcr_asy_prdn_h
    WHERE proc_nm = 'Winding'
        AND (wk_end_dtms >= ?F::date-3 AND wk_end_dtms < ?F::date+1)
)
SELECT 
    a.pldo_nm AS "PLANT (ASB)",
    a.asy_eqp_nm AS "PROC (ASB)",
    a.wk_end_dtms AS "TIME (ASB)",

    (CASE
        WHEN LEFT(a.eqp_nm, 10) = 'ASSEMBLY  ' THEN '#' || SUBSTRING(a.eqp_nm, 14, 2) || ' (NJ6 ASB)'
        WHEN LEFT(a.eqp_nm, 9) = 'ASSEMBLY ' THEN '#' || SUBSTRING(a.eqp_nm, 13, 2) || ' (NJ6 ASB)'
        ELSE 'UNDEFINED'
    END) AS "EQP (ASB)",

    a.jero_id AS "J/R ID (ASB)",
    (SELECT AVG(nj6wndgap.isp_nvl_ctn) FROM ensj_staging_m_tb_einsp_njma061_crcr_isp_ifo_h WHERE isp_atc_id='SPCWND1077') AS "SEPA-ANODE GAP MC SIDE",
    (SELECT AVG(nj6wndgap.isp_nvl_ctn) FROM ensj_staging_m_tb_einsp_njma061_crcr_isp_ifo_h WHERE isp_atc_id='SPCWND1092') AS "SEPA-ANODE GAP OP SIDE",

    (CASE 
        WHEN SUBSTRING(a.isp_cell_id, 5, 1) = 'n' THEN 'X'
        ELSE SUBSTRING(a.isp_cell_id, 1, 20)
    END) AS "(+) LOT ID (ASB) + TRAY ID (ASB)",

    a.dfct_cd AS "NG Code (ASB)",

    w.proc_nm AS "PROC.",
    TO_CHAR(w.wk_end_dtms, 'MM-DD HH24:MI:SS') AS "TIME",

    (CASE 
        WHEN SUBSTRING(w.eqp_nm, 13, 6) = 'WINDER' 
            THEN '#' || SUBSTRING(w.eqp_nm, 10, 2)
        WHEN '#' || SUBSTRING(w.eqp_nm, 19, CHAR_LENGTH(w.eqp_nm)-POSITION('R' IN w.eqp_nm)-3) 
            THEN '#' || SUBSTRING(w.eqp_nm, 19, CHAR_LENGTH(w.eqp_nm)-3)
        WHEN SUBSTRING(w.eqp_nm, CHAR_LENGTH(w.eqp_nm)-3, 1) = '-' 
            THEN '#' || SUBSTRING(w.eqp_nm, CHAR_LENGTH(w.eqp_nm)-5, 5)
        WHEN '#' || SUBSTRING(w.eqp_nm, CHAR_LENGTH(w.eqp_nm)-2, 2) 
            THEN '#' || SUBSTRING(w.eqp_nm, CHAR_LENGTH(w.eqp_nm)-4, 4)
        WHEN w.eqp_nm IS NULL THEN NULL
        ELSE 'UNDEFINED'
    END) AS "EQP",

    w.wind_id AS "WIND ID",
    w.jero_id AS "J/R ID"

FROM asb_data a 
JOIN wnd_data w ON a.jero_id = w.jero_id
LEFT JOIN ensj_staging_m_tb_einsp_njma061_crcr_isp_ifo_h AS gap ON w.eqp_nm=w.eqp_nm

WHERE 
    (CASE
        WHEN LEFT(a.eqp_nm, 10) = 'ASSEMBLY  ' THEN '#' || SUBSTRING(a.eqp_nm, 14, 2) || ' (NJ6 ASB)'
        WHEN LEFT(a.eqp_nm, 9) = 'ASSEMBLY ' THEN '#' || SUBSTRING(a.eqp_nm, 13, 2) || ' (NJ6 ASB)'
        ELSE 'UNDEFINED'
    END) IN ('#19 (NJ6 ASB)', '#18 (NJ6 ASB)')

ORDER BY 
    "PLANT (ASB)" ASC,
    "EQP (ASB)" ASC,
    "TIME (ASB)" ASC,
    "J/R ID (ASB)" ASC;

