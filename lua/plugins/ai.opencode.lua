return {
  "anomalyco/opencode.nvim",

  init = function()
    vim.g.opencode_opts = {
      -- Prompts personalizados para su uso en español,
      -- acorde a las funciones de trabajo personalizados
      prompts = {

        -- EXPLAIN
        explain = {
          prompt = [[
   Explica @this de forma técnica y estructurada.

   Incluye:
   1. Qué hace el código (resumen ejecutivo).
   2. Flujo paso a paso.
   3. Decisiones importantes de diseño.
   4. Posibles riesgos o edge cases.
   5. Cómo podría mejorarse conceptualmente.

   Responde en español.
   No repitas el código salvo que sea necesario.
   ]],
          submit = true,
        },

        -- FIX
        fix = {
          prompt = [[
   Analiza @this y corrige:

   - Errores lógicos
   - Problemas de tipado
   - Posibles bugs silenciosos
   - Malas prácticas

   Entrega:
   1. Código corregido completo.
   2. Explicación breve de cada cambio.
   3. Si hay ambigüedad, menciona las suposiciones realizadas.

   Responde en español.
   ]],
          submit = true,
        },

        -- DIAGNOSE
        diagnose = {
          prompt = [[
   Diagnostica @this como si estuviera fallando en producción.

   Identifica:
   - Posibles causas de error
   - Condiciones de carrera
   - Problemas de concurrencia
   - Memory leaks
   - Problemas de performance
   - Errores de diseño

   Prioriza los problemas por severidad (Alta, Media, Baja).
   Responde en español.
   ]],
          submit = true,
        },

        -- REVIEW (nivel senior)
        review = {
          prompt = [[
   Haz una revisión profesional de código para @this.

   Evalúa:
   - Legibilidad
   - Cohesión y acoplamiento
   - Separación de responsabilidades
   - Claridad de nombres
   - Manejo de errores
   - Testabilidad
   - Escalabilidad

   Clasifica el código del 1 al 10 y justifica la calificación.
   Sugiere mejoras concretas.

   Responde en español.
   ]],
          submit = true,
        },

        -- TEST
        test = {
          prompt = [[
   Genera pruebas unitarias completas para @this.

   Requisitos:
   - Cubrir casos felices y edge cases.
   - Incluir casos de error.
   - Evitar mocks innecesarios.
   - Explicar brevemente qué valida cada test.

   Si el lenguaje lo permite, usa el framework estándar más común.
   Responde en español.
   ]],
          submit = true,
        },

        -- OPTIMIZE (mejorado)
        optimize = {
          prompt = [[
   Optimiza @this considerando:

   1. Rendimiento
   2. Legibilidad
   3. Complejidad algorítmica
   4. Uso innecesario de memoria
   5. Simplificación estructural

   Entrega:
   - Código optimizado completo.
   - Explicación breve de las mejoras.
   - Si el código ya es óptimo, explica por qué.

   Responde en español.
   ]],
          submit = true,
        },
      },

      -- Configuracion por defecto comentada para que no interfiera con
      -- la aplicacion de los comandos de <leader>av y <leader>ah
      --
      -- provider = {
      --   snacks = {
      --     win = {
      --       position = "right",
      --     },
      --   },
      -- },
    }
  end,

  dependencies = {
    { "folke/snacks.nvim" },
  },

  keys = {
    --
    -- Funciones para el manejo de la ventana emergente
    --
    {
      "<leader>aa",
      function()
        vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, {
          provider = {
            snacks = {
              win = {
                -- position = "right",
                width = math.floor(vim.o.columns * 0.25),
              },
            },
          },
        })

        require("opencode").toggle()
      end,
      mode = { "n" },
      desc = "Toggle OpenCode",
    },
    {
      "<leader>av",
      function()
        vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, {
          provider = {
            snacks = {
              win = {
                position = "bottom",
              },
            },
          },
        })

        require("opencode").toggle()
      end,
      mode = { "n" },
      desc = "OpenCode bottom",
    },
    {
      "<leader>ah",
      function()
        vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, {
          provider = {
            snacks = {
              win = {
                position = "right",
                width = math.floor(vim.o.columns * 0.25),
              },
            },
          },
        })

        require("opencode").toggle()
      end,
      mode = { "n" },
      desc = "OpenCode right",
    },

    --
    -- Funciones de trabajo con el agente
    --
    {
      "<leader>as",
      function()
        require("opencode").select({ submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode select",
    },
    {
      "<leader>ai",
      function()
        require("opencode").ask("", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask",
    },
    {
      "<leader>aI",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask with context",
    },
    {
      "<leader>ab",
      function()
        require("opencode").ask("@file ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask about buffer",
    },
    {
      "<leader>ap",
      function()
        require("opencode").prompt("@this", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode prompt",
    },
    --
    -- Funciones de trabajo especializadas
    --
    {
      "<leader>ape",
      function()
        require("opencode").prompt("explain", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode explain",
    },
    {
      "<leader>apf",
      function()
        require("opencode").prompt("fix", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode fix",
    },
    {
      "<leader>apd",
      function()
        require("opencode").prompt("diagnose", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode diagnose",
    },
    {
      "<leader>apr",
      function()
        require("opencode").prompt("review", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode review",
    },
    {
      "<leader>apt",
      function()
        require("opencode").prompt("test", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode test",
    },
    {
      "<leader>apo",
      function()
        require("opencode").prompt("optimize", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "OpenCode optimize",
    },
  },
}
