A continuación se dejan los espacios para insertar la tabla y las figuras.

### Promedio de $\text{PM}_{2.5}$ Pre/Post PPDA por estación
```{r}
#| label: tbl-resumen-gt
#| tbl-cap: "Concentraciones promedio de PM2.5 y cambio neto por estación."

# Preparamos los datos de la tabla (usando datos_cambio)
tabla1_datos <- datos_cambio %>%
  select(site, mean_Pre, mean_Post, reduccion, ymin_Pre, ymax_Pre, ymin_Post, ymax_Post) %>%
  mutate(across(where(is.numeric), ~ round(., 1)))

tabla1_datos %>%
  gt() %>%
  tab_header(
    title = md("**Evolución de la Concentración Anual de PM2.5 en la RM**"),
    subtitle = md("Comparación de promedios anuales antes (2014-2017) y después (2018-Actual) del PPDA.")
  ) %>%
  cols_label(
    site = "Estación",
    mean_Pre = "Promedio Pre-PPDA",
    mean_Post = "Promedio Post-PPDA",
    reduccion = "Reducción Neta",
    ymin_Pre = "CI Inf. Pre",
    ymax_Pre = "CI Sup. Pre",
    ymin_Post = "CI Inf. Post",
    ymax_Post = "CI Sup. Post"
  ) %>%
  data_color(
    columns = reduccion,
    palette = c("#F8766D", "white", "#00BFC4"), # Rojo (empeora) -> Blanco -> Azul (mejora)
    domain = c(min(tabla1_datos$reduccion, na.rm=TRUE), 0, max(tabla1_datos$reduccion, na.rm=TRUE))
  ) %>%
  tab_spanner( # Agrupamos los Intervalos de Confianza (CI)
    label = "Intervalo de Confianza (95%) - Pre PPDA",
    columns = c(ymin_Pre, ymax_Pre)
  ) %>%
  tab_spanner(
    label = "Intervalo de Confianza (95%) - Post PPDA",
    columns = c(ymin_Post, ymax_Post)
  ) %>%
  fmt_number(columns = where(is.numeric), decimals = 1) %>%
  tab_source_note(
    source_note = "Fuente: Datos SINCA vía AtmChile. LC: Las Condes, EB: El Bosque, PU: Pudahuel, QU: Quilicura, LF: La Florida, PA: Puente Alto, CEI: Cerrillos, TALI: Talagante, CN: Cerro Navia, IN: Independencia, CEII: Cerrillos 1."
  )
```
