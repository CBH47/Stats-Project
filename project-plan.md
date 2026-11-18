# ST 370 Simulation Project — Agent Instructions

## Dataset
- File: `spotify_songs (1).csv` in project directory
- Current variable of interest: `valence` (musical positiveness, continuous, range ~0–1)
- Already loaded as dataframe `df` in `project.r`

## Style Rules
- All R code must use `set.seed()` for reproducibility
- Use `ggplot2` with theme_bw() and fill color `#419caa`
- Every plot needs: informative title, x-axis label, y-axis label (or empty string if not applicable), no legend
- Save plots as PNG via `ggsave()` at 7x5 inches
- SOCS analysis must use statistical terminology (skewed, kurtosis, IQR, etc.)
- Z-score calculations: show formula and numeric work
- Sampling distribution: exactly 10,000 iterations

---

## Part 1 — Distribution Exploration (Partially Complete)

### Already Done (`project.r`)
Three plots saved:
1. `valenceViolin.png` — violin plot of valence
2. `valenceBoxplot.png` — boxplot of valence
3. `valenceHist.png` — histogram of valence

### Still Needed
- Complete SOCS paragraph in `socs-analysis.txt`:
  - **S**hape: Draft exists but needs refinement (note tent-shaped due to [0,1] bounds)
  - **O**utliers: Draft is vague — should apply 1.5×IQR rule explicitly and report whether any points fall outside
  - **C**enter: Currently says "approximately 0.5" — must compute and report exact mean and median values from `df$valence`
  - **S**pread: Empty ("Not sure what to write here") — must compute and report std dev, IQR, min, max
- One sentence reflection: was the distribution surprising? What are you curious about?

---

## Part 2 — Central Limit Theorem Calculations (NOT STARTED)

### Tasks
1. **n=1**: Sample 1 unit at random. Compute its Z-score. Explain whether a Z-score makes sense for a single observation (answer: yes, it's just standardizing one value from the population).
2. **n=10**: Sample 10 units, compute their mean. Compute Z-score of that sample mean using `mu` and `sigma/sqrt(10)`. Explain whether it makes sense.
3. **n=40**: Sample 40 units, compute their mean. Compute Z-score. State if the value is unusual (|Z| > 2?).

### Output Format
- Show each formula: `X̄ ~ N(μ, σ/√n)`
- Report numeric values for μ (population mean), σ (population std dev), n, sample mean, and resulting Z-score
- Use LaTeX-style math in comments or a separate .qmd file

---

## Part 3 — Sampling Distribution Visualization (NOT STARTED)

### Tasks
1. Create a vector of 10,000 sample means:
   ```r
   set.seed(<your_seed>)
   n <- 40
   num_samples <- 10000
   population_mean <- mean(df$valence)
   population_sd <- sd(df$valence)
   sample_means <- replicate(num_samples, {
     mean(sample(df$valence, size = n))
   })
   ```
2. Plot the distribution of `sample_means` (histogram or density plot)
3. Add a vertical line (`geom_vline()`) at the position of your Part 2 n=40 sample mean
4. Title should reference "Sampling Distribution of the Mean"

---

## File Structure
```
project.r          — main R script (add Parts 2–3 here)
valenceViolin.png  — already generated
valenceBoxplot.png — already generated
valenceHist.png    — already generated
samplingDist.png   — new plot for Part 3
socs-analysis.txt  — needs completion
```

## Optional Sections (Skip unless requested)
- Hypothesis testing / p-values
- Linear regression / visualizing relationships between variables
