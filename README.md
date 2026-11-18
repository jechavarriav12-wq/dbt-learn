# dbt-learn

Repositorio de práctica de **dbt Core sobre BigQuery**, dentro de mi ruta de analista de datos a Data Engineer.
Aquí voy registrando lo que aprendo, con ejercicios que corren de verdad contra BigQuery.

## Stack

| Herramienta | Uso |
|---|---|
| dbt Core 1.x + `dbt-bigquery` | Transformación de datos con SQL modular, tests y documentación |
| Google BigQuery | Data warehouse |
| Python + uv | Entorno virtual y dependencias |
| Git + GitHub | Control de versiones |

## Estructura

```
dbt-learn/
├── jaffle_shop/              # Proyecto dbt
│   ├── models/
│   │   └── example/
│   │       ├── my_first_dbt_model.sql
│   │       ├── my_second_dbt_model.sql   # lee del primero con ref()
│   │       ├── mi_tercer_modelo.sql      # lee del segundo con ref()
│   │       └── schema.yml                # tests de calidad
│   └── dbt_project.yml       # Configuración del proyecto
├── pyproject.toml            # Dependencias de Python
└── uv.lock                   # Versiones exactas instaladas
```

## Conceptos practicados

- [x] Modelos: un archivo `.sql` se convierte en tabla o vista con `dbt run`
- [x] `ref()`: dependencias entre modelos y orden de ejecución
- [x] Linaje y documentación con `dbt docs`
- [x] Tests genéricos (`unique`, `not_null`) con `dbt test`
- [ ] Sources y frescura de datos (`freshness`)
- [ ] Seeds (`dbt seed`)
- [ ] Capas staging → intermediate → marts
- [ ] Materializaciones (view, table, incremental)
- [ ] Tests personalizados
- [ ] Jinja, macros y paquetes (`dbt_utils`)

## Cómo correrlo

**Requisitos:** [uv](https://docs.astral.sh/uv/), [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) y un proyecto de Google Cloud con BigQuery.

```bash
git clone https://github.com/jechavarriav12-wq/dbt-learn.git
cd dbt-learn
uv sync                                   # crea el entorno e instala dbt
gcloud auth application-default login     # credenciales para BigQuery
```

Crea el archivo `~/.dbt/profiles.yml` con tu conexión:

```yaml
jaffle_shop:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: TU_PROJECT_ID
      dataset: dbt_tu_nombre
      threads: 4
      location: US
```

Luego:

```bash
cd jaffle_shop
uv run dbt debug    # verifica la conexión
uv run dbt build    # construye los modelos y corre los tests
uv run dbt docs generate && uv run dbt docs serve   # documentación y linaje
```

## Bitácora

| Fecha | Avance |
|---|---|
| 2026-11-17 | Instalación de dbt + BigQuery, primeros modelos, `ref()`, tests y linaje |

## Próximos pasos

- Completar el curso *dbt Fundamentals* (dbt Learn)
- Cargar los datos de *jaffle_shop* y construir modelos de staging y marts
- Proyecto 1: pipeline de contratación pública en Colombia (SECOP II) con dbt y Power BI