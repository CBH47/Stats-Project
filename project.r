set.seed(73213712)

library(ggplot2)


df <- read.csv("C:/Users/camha/OneDrive/Desktop/Comp Sci/Stats Project/spotify_songs (1).csv")
data_vector <- df$valence

p <- ggplot(df, aes(x = valence, y = "")) +
geom_violin(fill = "#419caa") +
theme_bw() +
theme(legend.position = "none") +
ggtitle("Violin plot (with no grouping)") +
ylab("") +
xlab("Valence")


ggsave("valenceViolin.png", p, width = 7, height = 5)

p2 <- ggplot(df, aes(x = valence, y = "")) +
    geom_boxplot(fill = "#419caa") +
    theme_bw() +
    theme(legend.position = "none") +
    ggtitle("Boxplot of Valence") +
    ylab("") +
    xlab("Valence")

ggsave("valenceBoxplot.png", p2, width = 7, height = 5)

p3 <- ggplot(df, aes(x = valence)) + 
    geom_histogram()

ggsave("valenceHist.png", p3, width = 7, height = 5)

# =============================================================================
# Part 2 — Central Limit Theorem Calculations
# =============================================================================

population_mean <- mean(df$valence)
population_sd   <- sd(df$valence)

cat("Population parameters:\n")
cat(sprintf("  mu (mean)    = %.4f\n", population_mean))
cat(sprintf("  sigma (sd)   = %.4f\n\n", population_sd))

# --- n = 1 ---------------------------------------------------------------
set.seed(73213712)
sample_n1 <- sample(df$valence, size = 1)
z_n1 <- (sample_n1 - population_mean) / population_sd

cat("n = 1:\n")
cat(sprintf("  Sample value: %.4f\n", sample_n1))
cat(sprintf("  Z-score formula: Z = (x - mu) / sigma\n"))
cat(sprintf("  Z = (%.4f - %.4f) / %.4f = %.4f\n\n",
            sample_n1, population_mean, population_sd, z_n1))
cat("  A Z-score makes sense for a single observation — it simply tells us how many\n")
cat("  standard deviations the value lies from the population mean.\n\n")

# --- n = 10 --------------------------------------------------------------
set.seed(73213712)
sample_n10 <- sample(df$valence, size = 10)
mean_n10   <- mean(sample_n10)
se_n10     <- population_sd / sqrt(10)
z_n10      <- (mean_n10 - population_mean) / se_n10

cat("n = 10:\n")
cat(sprintf("  Sample means: %s\n", paste(round(sample_n10, 4), collapse = ", ")))
cat(sprintf("  Sample mean: %.4f\n", mean_n10))
cat(sprintf("  X-bar ~ N(mu, sigma/sqrt(n)) => N(%.4f, %.4f)\n", population_mean, se_n10))
cat(sprintf("  Z = (%.4f - %.4f) / %.4f = %.4f\n\n",
            mean_n10, population_mean, se_n10, z_n10))
cat("  A Z-score makes sense here too — we are standardizing the sample mean using\n")
cat("  its expected sampling distribution N(mu, sigma/sqrt(n)).\n\n")

# --- n = 40 --------------------------------------------------------------
set.seed(73213712)
sample_n40 <- sample(df$valence, size = 40)
mean_n40   <- mean(sample_n40)
se_n40     <- population_sd / sqrt(40)
z_n40      <- (mean_n40 - population_mean) / se_n40

cat("n = 40:\n")
cat(sprintf("  Sample mean: %.4f\n", mean_n40))
cat(sprintf("  X-bar ~ N(mu, sigma/sqrt(n)) => N(%.4f, %.4f)\n", population_mean, se_n40))
cat(sprintf("  Z = (%.4f - %.4f) / %.4f = %.4f\n\n",
            mean_n40, population_mean, se_n40, z_n40))

if (abs(z_n40) > 2) {
  cat(sprintf("  |Z| = %.4f > 2, so this sample mean is unusual.\n\n", z_n40))
} else {
  cat(sprintf("  |Z| = %.4f <= 2, so this sample mean is not unusual.\n\n", z_n40))
}

# =============================================================================
# Part 3 — Sampling Distribution Visualization
# =============================================================================

set.seed(73213712)
n        <- 40
num_samples <- 10000
sample_means <- replicate(num_samples, {
  mean(sample(df$valence, size = n))
})

cat(sprintf("\nSampling distribution (n=%d, %d samples):\n", n, num_samples))
cat(sprintf("  Mean of sample means: %.4f\n", mean(sample_means)))
cat(sprintf("  SD of sample means:   %.4f\n", sd(sample_means)))
cat(sprintf("  Theoretical SE:       %.4f\n", population_sd / sqrt(n)))

p4 <- ggplot(data.frame(x = sample_means), aes(x = x)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50, fill = "#419caa", color = "white") +
  geom_density(alpha = 0.3) +
  geom_vline(xintercept = mean_n40, color = "red", linewidth = 1.2) +
  theme_bw() +
  theme(legend.position = "none") +
  ggtitle("Sampling Distribution of the Mean (n=40)") +
  xlab("Sample Mean") +
  ylab("Density")

ggsave("samplingDist.png", p4, width = 7, height = 5)