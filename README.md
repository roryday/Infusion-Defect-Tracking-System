# 📊 CEF Infusion Defect Trace & Root Cause Dashboard

This project presents a SQL-driven analytics workflow for tracking and investigating **infusion defects** in the **Assembly CEF process** of battery cell manufacturing.  
> ⚠️ *Note: All data and dashboards are based on **sample data** only, as the real data is confidential.*

---

## 🧪 Background

In the **battery assembly process**, cells go through a **CEF (Cylindrical cell Electrolyte Filling)** stage. During this stage, two primary defects have been identified:

- 🔴 **Infusion Defect** (`dfct_cd = 5`): Electrolyte fails to properly fill due to upstream physical misalignment  
- 🟠 **Filling Defect** (`dfct_cd = 4`): Incomplete or partial filling  
- ✅ **OK Cell** (`dfct_cd = 0`): No detected issues  

The **infusion defect** is the focus of this project. It was discovered that these defects are primarily linked to the **Winder process**, which directly precedes CEF.

---

## ⚙️ Root Cause Analysis

Key findings from engineering knowledge:

- The **gap between the separator and anode** is a **critical-to-quality (CTQ)** parameter  
- This gap varies by **Winder equipment** and is captured in the `isp_ifo_h` table

When an infusion defect occurs at the CEF stage, it is necessary to:

1. **Track which Winder equipment was used** for the defective cell  
2. **Compare the separator–anode gap** for that equipment  
3. **Visualize and monitor trends** in the gap over time to preemptively catch equipment deviations

---

## 🔍 Project Objective

To build a **dashboard and traceability system** that:

- Detects infusion defects (`dfct_cd = 5`) in real time  
- Links back to **Winder equipment** used  
- Highlights potential CTQ drift (separator–anode gap)  

This supports proactive **root cause identification**, reduces time-to-action, and improves manufacturing yield.

---

## 🧰 Tools & Tech

- **SQL** (PostgreSQL): complex multi-table joins, string manipulation, `CASE` logic, subqueries, and filtering  
- **Tableau**: dashboards with bar charts, box plots, dot plots, LOD expressions, and conditional formatting  
- **GitHub**: project version control and portfolio publishing

---

## 🧠 SQL Skills Demonstrated

📄 SQL script used: [`CEF_Infusion_to_WND.sql`](SQL/CEF_Infusion_to_WND.sql)

Key capabilities:
- Multi-layered `WITH` CTEs for cleaner structure
- Conditional formatting using `CASE` inside `SELECT` and `WHERE`
- `SUBSTRING`, `POSITION`, and `LEFT` for string parsing from equipment codes
- Use of `JOIN`s across MES and CTQ (gap) tables
- Filtering logic with date math: `::date-2`, `::date+1`
- Subqueries for reference metrics (`AVG(gap)` for each machine)

---

## 📈 Sample Insights

- Infusion defects were **concentrated in Winder#3 and #7**, indicating defect clustering by equipment  
- These winders showed **lower average separator–anode gaps** and **higher variability**, making them root cause candidates  
- Dashboard-driven monitoring provided **real-time visibility** into upstream defect causes, improving both responsiveness and overall yield

---

## 🖼️ Dashboard Preview

![Dashboard Screenshot](visuals/CEF_Infusion_Defect_Dashboard.png)

---

## 👨‍🔧 Author

Created by a **battery process engineer** transitioning into a **data analytics role**.  
This capstone bridges hands-on manufacturing experience with real-time data analysis and visualization.

---
