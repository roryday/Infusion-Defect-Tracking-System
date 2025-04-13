# 📊 CEF Infusion Defect Trace & Root Cause Dashboard

This project presents a SQL-driven analytics workflow for tracking and investigating **infusion defects** in the **Assembly CEF process** of battery cell manufacturing.
*Note that all data presented is sample data since real data is confidential,

---

## 🧪 Background
In the **battery assembly process**, cells go through a **CEF (Cylindrical cell Electrolyte Filling)** stage. During this stage, two primary defects have been identified:

- 🔴 **Infusion Defect** (`dfct_cd = 5`): Electrolyte fails to properly fill due to upstream physical misalignment
- 🟠 **Filling Defect** (`dfct_cd = 4`): Incomplete or partial filling
- ✅ **OK Cell** (`dfct_cd = 0`): No detected issues

The **infusion defect** is the focus of this project. It was discovered that these defects are primarily linked to the **Winder process**, which directly precedes CEF.

---

## ⚙️ Root Cause Analysis
Key findings from the engineering team:
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
- **SQL**: PostgreSQL-based multi-table joins for defect traceability
- **Dashboards**: (Spotfire / Tableau / custom visualization — not shown here)
- **GitHub**: For project version control and portfolio presentation

---

## 📂 Repository Structure
```
defect_tracking_project/
├── README.md                   # Project documentation
├── sql/
│   └── defect_trace_query.sql  # SQL logic to track defect root causes
├── data/
│   ├── asb_data_1000rows.csv   # Sample assembly data
│   ├── wnd_data_1000rows.csv   # Winder process data
│   └── isp_ifo_h_1000rows.csv  # Separator–anode gap (CTQ) data
├── notebooks/
│   └── analysis.ipynb          # Optional EDA and joins in pandas
└── visuals/
    └── defect_dashboard.png    # Dashboard screenshot
```

---

## 📈 Sample Insights
- Infusion defects were **concentrated in Winder#3 and #7**, showing below-tolerance gap values
- CTQ drift in separator–anode gap preceded defect spike by ~1 day
- Real-time monitoring prevented escalation by alerting line engineers

---

## 👨‍🔧 Author
Created by a **battery process engineer** with transition goals into **data analytics**. This capstone demonstrates cross-functional expertise between engineering processes and data-driven monitoring systems.

---

Let me know if you want a visualization notebook or want to deploy this SQL on a dashboard framework.
