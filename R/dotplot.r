#' Make a plot
#'
#' @param data_to_plot Data to plot
#' @param ref_line Reference line
#' @param xmin Lower limit on x-axes
#' @param xmax Upper limit on x-axes
#' @param all_data All the data (used to make median line)
#'
#' @return A plot
#' @export
#'
dotplot <- function(data_to_plot = NULL, all_data = NULL, ref_line = 30, xmin = 0, xmax = 1) {
  library(ggplot2)
  library(magrittr)
  boomr <- unique(all_data$bohf)

  farger <- shinymap::skde_colors(num = 5)[seq_len(length(boomr))]
  names(farger) <- boomr
  ymax <- plyr::round_any(max(all_data$tid_min) + 1, 10, f = ceiling)

  ggplot(data = data_to_plot %>%
        dplyr::filter(dplyr::between(dato, xmin, xmax)),
        aes(x = dato, y = tid_min)) +
    geom_point(aes(color = bohf)) +
    geom_hline(aes(yintercept = ref_line)) +
    geom_hline(yintercept = median(all_data$tid_min),
               linetype = "dashed",
               color = "red") +
    scale_y_continuous(name = "Antall minutter",
                                limits = c(0, ymax),
                                breaks = round(seq(0, ymax, length.out = 4))) +
    scale_x_date(name = "Dato",
                          limits = c(xmin, xmax),
                          breaks = round(seq(xmin, xmax, length.out = 6)),
                          date_labels = "%m.%Y") +
    scale_color_manual(name = "Boområde", values = farger) +
    annotate("label", x = xmin, y = ref_line,
                      label = paste0("ref-line = ", ref_line)) +
    annotate("label", x = xmin, y = median(all_data$tid_min),
                      label = paste0("Median = ", median(all_data$tid_min))) +
    ggthemes::theme_tufte() +
    theme(axis.text = element_text(size = 14),
          axis.title = element_text(size = 22),
          axis.ticks = element_blank(),
          axis.title.x = element_text(margin = margin(t = 25)),
          axis.title.y = element_text(margin = margin(r = 25)),
          legend.position = "bottom")
}
