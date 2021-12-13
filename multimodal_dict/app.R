# Загружаем библиотеки
library(shiny)
library(shinydashboard)
library(wordcloud2) 
library(readr)
library(timevis)
library(dplyr)


# Открываем файлы и сохраняем их в переменные
en_freq <-read.csv("www/en_full_freq.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
ru_freq <-read.csv("www/ru_full_freq.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
en_dict <-read.csv2("www/Modern_EN.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
ru_dict <-read.csv2("www/Modern_RU.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
en_etym <-read.csv2("www/Etymology_EN.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
en_comment <-read.csv2("www/Comment_EN.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")
ru_comment <-read.csv2("www/Comment_RU.csv", header = TRUE, stringsAsFactors=FALSE, encoding = "UTF-8")

# Сохраняем переменные для timeline

academ <- data.frame(
  id      = 1:5,
  content = c("<b>Adjective</b> - Definition 1", "<b>Adjective</b> - Definition 2", 
              "<b>Adjective</b> - Definition 3", "<b>Noun</b> - Definition 1",
              "<b>Noun</b> - Definition 2"),
  start   = c("1610-01-01", "1588-01-01", "1886-01-01", "1586-01-01", "1587-01-01"),
  end     = c("1777-01-01", "2021-01-01", "2021-01-01", "1846-01-01", "2021-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;",
            "color: navy; background-color: #8fbdf2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8ff2ed; border:2px solid DodgerBlue;"),
  type    = "range") 

edu <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1531-01-01", "1888-01-01", "1616-01-01"),
  end     = c("1661-01-01", NA, "2021-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = c("range", "box","range")
)

exam <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1387-01-01", "1510-01-01", "1612-01-01"),
  end     = c("1861-01-01","2021-01-01", "2021-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = "range")

manag <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1588-01-01", "1666-01-01", "1793-01-01"),
  end     = c("2021-01-01","1863-01-01", "1880-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = "range")

prof <- data.frame(
  id      = 1:6,
  content = c("<b>Adjective</b> - Definition 1", "<b>Adjective</b> - Definition 2", "<b>Adjective</b> - Definition 3", 
              "<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1420-01-01", "1747-01-01", "1879-01-01",
              "1848-01-01", "1811-01-01", "1861-01-01"),
  end     = c("1881-01-01", "2021-01-01", "1978-01-01",
              "2021-01-01", "2021-01-01", "1977-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;",
            "color: navy; background-color: #8fbdf2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8fa6f2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8ff2ed; border:2px solid DodgerBlue;"),
  type    = "range") 

school <- data.frame(
  id      = 1:16,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3", 
              "<b>Noun</b> - Definition 4", "<b>Noun</b> - Definition 5", "<b>Noun</b> - Definition 6",
              "<b>Noun</b> - Definition 7", "<b>Noun</b> - Definition 8", "<b>Noun</b> - Definition 9",
              "<b>Noun</b> - Definition 10", "<b>Noun</b> - Definition 11", "<b>Verb</b> - Definition 1",
              "<b>Verb</b> - Definition 2", "<b>Verb</b> - Definition 3", 
              "<b>Verb</b> - Definition 4", "<b>Verb</b> - Definition 5"),
  start   = c("1000-01-01", "1375-01-01", "1612-01-01", "1812-01-01",
              "1890-01-01", "1400-01-01", "1614-01-01", "1828-01-01",
              "816-01-01", "1400-01-01", "1892-01-01", "1573-01-01",
              "1592-01-01", "1869-01-01", "1885-01-01", "1902-01-01"),
  end     = c("2021-01-01", "1781-01-01", "2021-01-01","1976-01-01",
              "1971-01-01", "2021-01-01", "1684-01-01", "2021-01-01",
              "1450-01-01", "1601-01-01", NA, "2021-01-01",
              "1628-01-01", "2021-01-01", NA, NA),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: navy; background-color: #8fbdf2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8fa6f2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8ff2ed; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8fbdf2; border:2px solid DodgerBlue;",
            "color: navy; background-color: #8ff2ed; border:2px solid DodgerBlue;"),
  type    = c("range", "range", "range", "range",
              "range", "range", "range", "range",
              "range", "range", "box", "range",
              "range", "range", "box", "box"))

sci <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1289-01-01", "1588-01-01", "1480-01-01"),
  end     = c("2021-01-01", "1839-01-01", "1660-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = "range")

stud <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1398-01-01", "1936-01-01", "1651-01-01"),
  end     = c("2021-01-01", "1951-01-01", "1858-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = "range")

teach  <- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1290-01-01", "1375-01-01", "1834-01-01"),
  end     = c("1350-01-01", "2021-01-01", NA),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = c("range", "range", "box"))

uni<- data.frame(
  id      = 1:3,
  content = c("<b>Noun</b> - Definition 1", "<b>Noun</b> - Definition 2", "<b>Noun</b> - Definition 3"),
  start   = c("1300-01-01", "1374-01-01", "1494-01-01"),
  end     = c("2021-01-01", "1843-01-01","1642-01-01"),
  style = c("color: green; background-color: #99f28f; border:2px solid MediumSeaGreen;", 
            "color: green; background-color: #71ebb5; border:2px solid MediumSeaGreen;",
            "color: green; background-color: #8ff2ad; border:2px solid MediumSeaGreen;"),
  type    = "range")

# Заголовок

header <- dashboardHeader(title = "Мультимодальный учебный словарь 
                          историко-культурологического типа - BETA",
                          titleWidth = 800
                          )

# Боковая панель

sidebar <- dashboardSidebar(
  sidebarMenu(
    #sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
    #                  label = "Search..."),
    
    menuItem("About / О словаре", icon = icon("info"), tabName = "about",
             badgeLabel = "info", badgeColor = "green"
    ),
    menuItem("Wordcloud", icon = icon("icons"), startExpanded = FALSE,
             menuSubItem("Ключевые слова", tabName = "freq_ru"),
             menuSubItem("Keywords", tabName = "freq_en")
             

    ),
    menuItem("Русский язык", icon = icon("language"), startExpanded = FALSE,
             menuSubItem("Наука", tabName = "sci_ru"),
             menuSubItem("Образование", tabName = "edu_ru"),
             menuSubItem("Преподаватель", tabName = "teach_ru"),
             menuSubItem("Профессиональный", tabName = "prof_ru"),
             menuSubItem("Руководитель", tabName = "man_ru"),
             menuSubItem("Студент", tabName = "stud_ru"),
             menuSubItem("Университет", tabName = "uni_ru"),
             menuSubItem("Учебный", tabName = "acad_ru"),
             menuSubItem("Школа", tabName = "schol_ru"),
             menuSubItem("Экзамен", tabName = "ex_ru")
    ),
    menuItem("English", icon = icon("globe-europe"), startExpanded = FALSE,
             menuSubItem("Academic", tabName = "acad_en"),
             menuSubItem("Education", tabName = "edu_en"),
             menuSubItem("Examination", tabName = "ex_en"),
             menuSubItem("Manager", tabName = "man_en"),
             menuSubItem("Professional", tabName = "prof_en"),
             menuSubItem("School", tabName = "schol_en"),
             menuSubItem("Science", tabName = "sci_en"),
             menuSubItem("Student", tabName = "stud_en"),
             menuSubItem("Teacher", tabName = "teach_en"),
             menuSubItem("University", tabName = "uni_en")
    )
  ),
  textOutput("res")
)

# Основное содержание словаря

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "freq_en",
            h2("Тематическое поле «Education»",
               style = "text-align: left;
               font-style: normal;"),
            br(),br(),
            wordcloud2Output('wordcloud_en'),
            br(),br(),
            style = "text-align: right; 
            font-style: italic;
            font-size: 17px;",
            "based on the articles from",
            tags$a(href="https://www.education-today.co.uk/", target="_blank",
                   "Education Today Magazine")
     
    ),
        tabItem(tabName = "freq_ru",
            h2("Тематическое поле «Образование»",
               style = "text-align: left;
               font-style: normal;"),
            br(),br(),
            wordcloud2Output('wordcloud_ru'),
            br(),br(),
            style = "text-align: right; 
            font-style: italic;
            font-size: 17px;",
            "по материалам",
            tags$a(href="http://edu-inform.ru/", target="_blank",
                   "Образовательного портала «EDU-Inform»")
    ),

    tabItem("sci_ru",
            h2("На-у́-ка"),
            fluidRow( 
              tabBox(title = tagList(h5(tags$i("Сущ., неодуш., жен. род, 1-е скл."))),
                     height = "350px",
                     width = 7,
                     tabPanel("Значение", 
                              style = "font-size: 15px; text-align: justify;",
                            tags$b("1."),
                              "система знаний о закономерностях развития 
                              природы и общества и способах воздействия 
                              на окружающий мир",
                             tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                             "взаимодействие науки и техники"),
                            tags$b("2."), tags$i("разг."),
                              "то, что поучает, даёт опыт, урок",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                             "Не плачь, что больно. Это тебе наука."),
                            tags$b("3."), tags$i("устар."),
                              "обучение какому-либо ремеслу",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                             "отдать сына в науку к сапожнику")
                     ),
                     tabPanel("Этимология", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «наука», означающее «определенную область
                              знаний», является русским – исконным – по происхождению:",
                              br(),
                              "от праслав. «*na- + *učiti», от др.-русск. «укъ» «учение»."
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "text-align: justify; outline-style: dotted; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "На Руси наука возникла и развивалась с древности. 
                              Об этом свидетельствуют памятники письменности и техники. 
                              Особенно высокий уровень знаний был достигнут в зодчестве 
                              и строительном деле, а также в различных ремеслах и 
                              металлообработке.",
                              br(), br(),
                              "Центрами древнерусской науки были монастыри, 
                              при которых нередко существовали школы. Монашествующие 
                              стали первыми русскими учеными и интеллектуалами. 
                              В современном контексте самостоятельной наука считается, 
                              если у нее имеется свой объект, предмет исследования 
                              и своя терминология."),
                     tabPanel("Морфемы",
                              br(),br(),
                              img(src = "sci_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D0%BD%D0%B0%D1%83%D0%BA%D0%B0", 
                                     target="_blank","Подробнее"))
              ),
              infoBox("Произношение", "[nɐˈukə]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "sci_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D0%BD%D0%B0%D1%83%D0%BA%D0%B0&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D0%BD%D0%B0%D1%83%D0%BA%D0%B0&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D0%BD%D0%B0%D1%83%D0%BA%D0%B0%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
                     box( img(src = "sci_ru.jpg", height = 330, 
                     style = "display: block; margin-left: auto; margin-right: auto;")
                     ),
                     box(style = "text-align: center;",
                     HTML('<iframe width="500" height="315" 
                              src="https://www.youtube.com/embed/eP1wlpJe4Zs" 
                              title="YouTube video player" 
                              frameborder="0" allow="accelerometer; autoplay; 
                              clipboard-write; encrypted-media; gyroscope; 
                              picture-in-picture" allowfullscreen></iframe>')
                     )
            )
    ),
    tabItem("edu_ru",
            h2("Об-ра-зо-ва́-ни·е"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., неодуш., ср. род, 2-е скл."))),
                     height = "345px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "то, что образовалось, возникло в результате какого-либо процесса",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "процесс образования горных пород",
                                              br(),
                                              "День образования Советской Армии"),
                              tags$b("2."), tags$i("разг."),
                              "процесс усвоения знаний; обучение, просвещение",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                              "Без образования в наше время не проживёшь.")
                     ),
                     tabPanel("Этимология",
                              style = "text-align: justify; outline-style: dotted; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «образование» происходит от русск.-церк.-слав. 
                              «образованиѥ», восходящего к праслав. глаголу «*образовати» 
                              «создавать образ, образы».",
                              br(),br(),
                              "В XIX в. стало использоваться в русском литературном языке 
                              как калька с немецкого языка «Bildung»."
                     ),
                     tabPanel("Историко-культурный комментарий",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "В зависимости от характера подготовки к жизни и труду 
                              различают общее образование (начальное и среднее) – дает знания, 
                              навыки, необходимые каждому человеку независимо от будущей 
                              специальности, профессии, и специальное образование – дает знания,
                              навыки, умения, необходимые работнику определенной профессии 
                              и определенного уровня квалификации.",
                              br(), br(),
                              "В современной России утверждается личностно-ориентированная модель образования, 
                              опирающаяся на национальные и мировые исторические традиции, 
                              а также на учет возможностей, предоставляемых новыми 
                              информационными технологиями. "
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "edu_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[ɐbrəzɐˈvanʲɪɪ̯ə]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "edu_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5&year_start=1800&year_end=2019&corpus=36&smoothing=3", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
              box( img(src = "edu_ru.png", height = 315,
                       style = "display: block; margin-left: auto; margin-right: auto;")
              ),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                   src="https://www.youtube.com/embed/oj-80sXDPyQ" 
                   title="YouTube video player" 
                   frameborder="0" allow="accelerometer; autoplay; 
                   clipboard-write; encrypted-media; gyroscope; 
                   picture-in-picture" allowfullscreen></iframe>')
              )
            )
    ),
    tabItem("teach_ru", 
            h2("Пре-по-да-ва́-тель"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., одуш., муж. род, 2-е скл."))),
                     height = "250px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "тот, кто занимается преподаванием чего-либо 
                              (обычно в среднем специальном или высшем учебном заведении)",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "работать преподавателем в театральном училище"),
                     ),
                     tabPanel("Этимология",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «преподаватель» образовано от глагола «преподавать» 
                              (пре- + по- + дать) от праслав. «*dā́tī; *dājā́tī; *dāvā́t
                              ī» в значении «дать, давать»." 
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «преподаватель»  употребляется в основном по отношению 
                              к работнику средней и высшей школы, штатная должность в вузах 
                              и средних специальных учебных заведениях.",
                              br(),
                              "В общеобразовательной школе – «учитель» ."
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "teach_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D0%BF%D1%80%D0%B5%D0%BF%D0%BE%D0%B4%D0%B0%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[prʲɪpədɐˈvatʲɪlʲ]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "teach_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D0%BF%D1%80%D0%B5%D0%BF%D0%BE%D0%B4%D0%B0%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D0%BF%D1%80%D0%B5%D0%BF%D0%BE%D0%B4%D0%B0%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D0%BF%D1%80%D0%B5%D0%BF%D0%BE%D0%B4%D0%B0%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
                     box( img(src = "teach_ru.jpg", height = 335,
                              style = "display: block; margin-left: auto; margin-right: auto;")
                     )
            )
    ),
    tabItem("prof_ru", 
            h2("Про-фес-си-о-на́ль-ный"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("прилагательное"))),
                     height = "250px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "относящийся к профессии, связанный с какой-либо профессией",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "профессиональное обучение"),
                              tags$b("2."), tags$i("разг."),
                              "относящийся к профессионализму, являющийся профессионалом",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                              "провести допрос на профессиональном уровне"),
                     ),
                     tabPanel("Этимология", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «профессия» пришло в русский язык в XVIII в., 
                              а в конце XIX в. появились производные.",
                              br(),
                              "Слово было заимствовано французами 
                              из латинского «professiō» «публичное заявление 
                              о роде своей деятельности». "
                     ),
                     tabPanel("Морфемы",
                              br(),br(),
                              img(src = "prof_morf.png", width = 500, style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D0%BF%D1%80%D0%BE%D1%84%D0%B5%D1%81%D1%81%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9 ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[prəfʲɪsʲɪɐˈnalʲnɨɪ̯]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "prof_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D0%BF%D1%80%D0%BE%D1%84%D0%B5%D1%81%D1%81%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D0%BF%D1%80%D0%BE%D1%84%D0%B5%D1%81%D1%81%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D0%BF%D1%80%D0%BE%D1%84%D0%B5%D1%81%D1%81%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            )
    ),
    tabItem("man_ru", 
            h2("Ру-ко-во-ди́-тель"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., одуш., муж. род, 2-е скл."))),
                     height = "300px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "тот, кто руководит кем-, чем-либо, 
                              направляет деятельность кого-, чего-либо ",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "руководитель туристского похода",
                                              br(),
                                              "классный руководитель"),
                     ),
                     tabPanel("Этимология", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «руководитель» происходит от существительного 
                              «рука» и глагола «водить». ",
                              br(),
                              "Существительное «рука» 
                              существует в русском языке с XI в. 
                              Образовано от общеславянского roka, семантически 
                              родственного указанному греческому слову – «ладонь, 
                              кисть руки», «собираю, складываю»."
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Руководитель в сфере образования - это тот, 
                              кто несёт ответственность за всё, что происходит в любом 
                              образовательном учреждении.",
                              br(), br(),
                              "Название должностей при 
                              этом отличается: в школе – директор или завуч, 
                              в университете, колледже или техникуме – ректор, 
                              проректор, декан, заместитель декана, заведующий кафедрой, 
                              в детском саду -  заведующий. Также существуют должности 
                              директора филиала, подразделения, руководителя управления 
                              или отдела."
                     ),
                     tabPanel("Морфемы",
                              br(),br(),
                              img(src = "manag_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%80%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D0%B8%D1%82%D0%B5%D0%BB%D1%8C ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[rʊkəvɐˈdʲitʲɪlʲ]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "manag_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%80%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D0%B8%D1%82%D0%B5%D0%BB%D1%8C&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%80%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D0%B8%D1%82%D0%B5%D0%BB%D1%8C&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%80%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            )
    ),
    tabItem("stud_ru", 
            h2("Сту-де́нт"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., одуш., муж. род, 2-е скл."))),
                     height = "250px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "учащийся высшего учебного заведения",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "Отчислить студента за неуспеваемость."),
                     ),
                     tabPanel("Этимология",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «студент» происходит от лат. studens 
                              (род. п. studentis) «старающийся», прич. 
                              от studere «усердно работать», из праиндоевр. 
                              *steu- «толкать, бить».",
                              br(), br(),
                              "В русском языке слово впервые использовалось 
                              в Духовном регламенте (1721 г.), народный скуде́нт
                              (под влиянием ску́дный), вероятно, заимствование
                              из польского «student» или немецкого «Student». "
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "В высших учебных заведениях, где обучение ведётся 
                              по ступеням бакалавриата и магистратуры (Болонская система), 
                              наименование студент применяется для обеих ступеней, 
                              например, студент бакалавриата, студент магистратуры. ",
                              br(),
                              "Наряду с этим, для обучающихся в магистратуре используется 
                              понятие магистрант."
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "stud_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%81%D1%82%D1%83%D0%B4%D0%B5%D0%BD%D1%82 ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[stʊˈdʲent]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "stud_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%81%D1%82%D1%83%D0%B4%D0%B5%D0%BD%D1%82&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%81%D1%82%D1%83%D0%B4%D0%B5%D0%BD%D1%82&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%81%D1%82%D1%83%D0%B4%D0%B5%D0%BD%D1%82%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
                     box( img(src = "students.jpg", height = 380,
                              style = "display: block; margin-left: auto; margin-right: auto;")
                     ),
                     box( style = "text-align: center;",
                     HTML('<iframe width="500" height="315" 
                          src="https://www.youtube.com/embed/HXo5emSnnQU" 
                          title="YouTube video player" frameborder="0" 
                          allow="accelerometer; autoplay; 
                          clipboard-write; encrypted-media; gyroscope; 
                          picture-in-picture" allowfullscreen></iframe>')
                    )
            )
    ),
    tabItem("uni_ru", 
            h2("У·ни-вер-си-те́т"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., неодуш., муж. род, 2-е скл."))),
                     height = "300px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "высшее учебно-научное заведение с различными 
                              гуманитарными и естественно-математическими 
                              отделениями (факультетами) ",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "математический факультет университета"),
                     ),
                     tabPanel("Этимология",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «университет» как название высшего учебного заведения, 
                              в котором имеются гуманитарные и естественно-математическими
                              факультеты, было заимствовано из немецкого «Universität» 
                              и восходит к латинскому «universitas» – «совокупность»,
                              вполне отражающему многопрофильность этого учреждения.",
                              br(),br(),
                              "Широкое распространение слово получило с 1755 г., 
                              с открытием первого университета в Москве. 
                              Диалектная форма существительного – «наверститут» – 
                              образовалась на основе двух самостоятельных слов – 
                              «наверстать» и «институт». "
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Первые университеты в России – Академический университет 
                              (1726–1766, СПб.) и Московский (с 1755 г.). 
                              В РФ существуют как государственные, так и 
                              негосударственные университеты, в том числе 
                              технического, медицинского, педагогического и других профилей. "
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "uni_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82 ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[ʊnʲɪvʲɪrsʲɪˈtʲet] ", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "uni_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82%3B%2Cc0#t1%3B%2C%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%82%D0%B5%D1%82%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
                     box( img(src = "uni_ru.jpg", height = 280,
                              style = "display: block; margin-left: auto; margin-right: auto;")
                     ),
                     box(style = "text-align: center;",
                     HTML('<iframe width="500" height="315" 
                              src="https://www.youtube.com/embed/rJyVap-MrTU" 
                              title="YouTube video player" 
                              frameborder="0" allow="accelerometer; autoplay; 
                              clipboard-write; encrypted-media; gyroscope; 
                              picture-in-picture" allowfullscreen></iframe>'))
            )
    ),
    tabItem("acad_ru",             
            h2("У·че́б-ный"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("прилагательное"))),
                     height = "250px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "связанный с организацией процесса обучения и соотносящийся 
                              по значению с существительным «учёба» (период с сентября по июнь) ",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "учебный отдел",
                                              br(),
                                              "учебная программа"),
                     ),
                     tabPanel("Этимология", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «учебный» происходит от существительного «учёба», 
                              далее от глагола учить, от праслав. «*učiti»."
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "academ_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%83%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9 ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[ʊˈt͡ɕebnɨɪ̯]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "academ_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%83%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%83%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%83%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            )
    ),
    tabItem("schol_ru",             
            h2("Шко́-ла"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., неодуш., жен. род, 1-е скл."))),
                     height = "500px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "учебное заведение, которое осуществляет общее образование 
                              и воспитание молодого поколения, или где даются 
                              специальные знания, профессиональные навыки",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "ходить в школу",
                                              br(),
                                              "музыкальная школа"),
                              tags$b("2."),
                              "приобретение знаний, выучки, опыта и система приёмов, 
                              обязательных упражнений, видов работ при изучении чего-либо, 
                              при овладении каким-либо мастерством, искусством",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                              "начальная школа игры на фортепиано"),
                              tags$b("3."), 
                              "направление, течение в науке, искусстве, литературе, 
                              общественно-политической мысли и т.п., 
                              обладающее характерными свойствами, методами, приёмами",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;",
                                              "писатели карамзинской школы"),
                              tags$b("4."), tags$i("сельхоз."),
                              "питомник, где выращивают растения (сеянцы или саженцы) 
                              до посадки на постоянное место"
                     ),
                     tabPanel("Этимология",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Слово «школа» происходит от лат. «schola», 
                              от др.-греч. «σχολή» «досуг; задержка, 
                              занятие в свободные часы, чтение, лекция, школа», 
                              из праиндоевр. «*segh»- «держать, обладать, иметь».",
                              br(), br(),
                              "Древние греки в свободное от работы время предпочитали 
                              посещать беседы философов и таким образом пополнять 
                              объем знаний. Исходным значением было «досуг», позже 
                              «непринуждённая беседа», а затем уже «место для беседы». 
                              Благодаря этому появилось слово школа – «место, где можно 
                              получить образование».",
                              br(),br(),
                              "Слово «школа» получило широкое 
                              распространение довольно поздно – в XVI–XVII вв., 
                              хотя известно было и раньше, но до этого времени 
                              его заменяли синонимом – словом «училище». 
                              Др.-русск. школа «училище» — начиная с 1388 г., 
                              заимствовано через польский язык. "
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Школа как учебно-воспитательное учреждение 
                              может быть государственной и частной.", 
                              tags$i("По характеру сообщаемых знаний"),
                              "школы делятся на общеобразовательные 
                              и профессиональные (специальные);",
                              br(),
                              tags$i("по уровню даваемого образования"),
                              "– начального общего, 
                              основного общего, полного общего, полного профильного;",
                              br(),
                              tags$i("по отношению к религии"),
                              "– на светские и религиозные 
                              (конфессиональные);",
                              br(),
                              tags$i("по полу учащихся"),
                              "– на мужские, 
                              женские, совместного обучения. ",
                              br(),br(),
                              "Вступление России в 
                              европейское образовательное пространство (Болонская декларация) 
                              предусматривает переход общеобразовательной школы 
                              на 12-летнее обучение и введение единого государственного 
                              экзамена для выпускников школы, результаты которого 
                              приравниваются к результатам вступительного экзамена 
                              при поступлении в вуз. "
                     ),
                     tabPanel("Морфемы",
                              br(),br(),
                              img(src = "school_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%88%D0%BA%D0%BE%D0%BB%D0%B0 ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[ˈʂkoɫə]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "school_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%88%D0%BA%D0%BE%D0%BB%D0%B0&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%88%D0%BA%D0%BE%D0%BB%D0%B0&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%88%D0%BA%D0%BE%D0%BB%D0%B0%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(width = 6,
              box( img(src = "school_ru.jpg", height = 335,
                       style = "display: block; margin-left: auto; margin-right: auto;")
              ),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315"
                   src="https://www.youtube.com/embed/EGYvr4Dx3pw?start=75" 
                   title="YouTube video player" 
                   frameborder="0" allow="accelerometer; autoplay; 
                   clipboard-write; encrypted-media; gyroscope; 
                   picture-in-picture" allowfullscreen></iframe>')
              )
            )
    ),
    tabItem("ex_ru",             
            h2("Эк-за́-мен"),
            fluidRow(
              tabBox(title = tagList(h5(tags$i("Сущ., неодуш., муж. род, 2-е скл."))),
                     height = "300px",
                     width = 7,
                     tabPanel("Значение",
                              style = "font-size: 15px; text-align: justify;",
                              tags$b("1."),
                              "проверочное испытание по какому-либо учебному предмету 
                              или испытание чьих-либо знаний и навыков",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 14px;", 
                                              "вступительный",
                                              br(),
                                              "государственный экзамен ",
                                              br(),
                                              "экзамен на водительские права "),
                     ),
                     tabPanel("Этимология", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Существует две версии, согласно которым в русский язык 
                              слово «экзамен» пришло из польского – «egzamen» или 
                              было заимствовано из немецкого – «Examen» «испытание», 
                              которые восходят к латинскому слову «examen» 
                              «вереница, куча, толпа; исследование, испытание», 
                              которое поначалу имело значение «стрелка у весов 
                              (приходящая в движение при взвешивании)», 
                              затем – «взвешивание», а уж потом – «испытание».",
                              br(),br(),
                              "В русском языке это слово известно с начала XVIII в., 
                              т.е. с эпохи Петра I и означает «проверка знаний 
                              учащихся по какому-либо предмету»."
                     ),
                     tabPanel("Историко-культурный комментарий", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 15px;",
                              "Экзамен, как форма итогового контроля, широко принята 
                              во всем мире. Экзамены бывают вступительными, 
                              переводными, выпускными. Форма проведения 
                              экзамена может быть письменной или устной. ",
                              br(),br(),
                              "На экзаменах по иностранному языку широко используются 
                              тесты. Результаты экзамена оцениваются в баллах 
                              путем анализа ответов с точки зрения соответствия 
                              требованиям программы."
                     ),
                     tabPanel("Морфемы",
                              br(),
                              img(src = "exam_morf.png", style = "  display: block; 
                                  margin-left: auto; 
                                  margin-right: auto;"),
                              br(),
                              tags$a(href="https://kartaslov.ru/%D1%80%D0%B0%D0%B7%D0%B1%D0%BE%D1%80-%D1%81%D0%BB%D0%BE%D0%B2%D0%B0-%D0%BF%D0%BE-%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D1%83/%D1%8D%D0%BA%D0%B7%D0%B0%D0%BC%D0%B5%D0%BD ", 
                                     target="_blank", "Подробнее"))
              ),
              infoBox("Произношение", "[ɛɡˈzamʲɪn]", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "exam_ru.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Примеры", "Национальный корпус русского языка", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://processing.ruscorpora.ru/search.xml?dpp=10&format=html&g=i_doc&kwsz=5&lang=ru&mode=main&nodia=1&out=kwic&req=%D1%8D%D0%BA%D0%B7%D0%B0%D0%BC%D0%B5%D0%BD&sampling=1&sort=i_grtagging&spd=10&spp=50&sr=1&text=lexform", 
                             target="_blank", "Перейти")
              ),
              infoBox("Частотность", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=%D1%8D%D0%BA%D0%B7%D0%B0%D0%BC%D0%B5%D0%BD&year_start=1800&year_end=2019&corpus=36&smoothing=3&direct_url=t1%3B%2C%D1%8D%D0%BA%D0%B7%D0%B0%D0%BC%D0%B5%D0%BD%3B%2Cc0", 
                             target="_blank", "Перейти")
              )
            ),
            fluidRow(
                     box(width = 4,
                         img(src = "exam_ru.png", height = 480,
                             style = "display: block; margin-left: auto; margin-right: auto;")
                     ),
                     box(width = 8, style = "text-align: center;",
                     HTML('<iframe width="700" height="450" 
                              src="https://www.youtube.com/embed/FYyxcJ3edpg" 
                              title="YouTube video player" 
                              frameborder="0" allow="accelerometer; autoplay; 
                              clipboard-write; encrypted-media; gyroscope; 
                              picture-in-picture" allowfullscreen></iframe>')
                     )
            )
    ),
    tabItem("acad_en",
            h2("Academic"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("adjective"))),
                     height = "350px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."), tags$i("B2"),
                              "relating to schools, colleges, and universities, 
                              or connected with studying and thinking, 
                              not with practical skills",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "academic subjects",
                                              br(),
                                              "academic books",
                                              br(),
                                              "academic institution"),
                              tags$b("2."), tags$i("C2"),
                              "used to describe someone who is clever and enjoys studying",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "The school is noted for its academic excellence."),
                              tags$b("3."), tags$i("C2"),
                              "based on ideas and theories and not related 
                              to practical effects in real life",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "a purely academic argument / question")
                     ),
                     tabPanel("Etymology",
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «academic» (adjective+noun) was borrowed
                              from Middle French «achademique, academique» 
                              and Latin «Acadēmicus» «of the school of 
                              the philosopher Plato », from Greek «Akadḗmeia», 
                              a place where Plato (c. 428-347 BC) taught. "
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The Akadēmeia, a park and gymnasium located 
                                     near Athens, was named in honor of the legendary 
                                     hero Akadēmos, who helped to rescue Helen 
                                     (the most beautiful woman of Greece and the 
                                     indirect cause of the Trojan War) by revealing 
                                     to her brothers the place where she was hidden 
                                     after she was abducted by Theseus.",
                              br(), br(),
                              "During the 4th century BC Plato taught in 
                                     a garden in Athens called the Akadēmeia, 
                                     which was named after this ancient hero. 
                                     It was there that Plato established his school, 
                                     which is, in name at least, the grandfather 
                                     of all modern academies."
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Adjective", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1610 - 1777"), tags$i("Obs."),
                              "belonging to the Academy, 
                                     the school or philosophy of Plato",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1588 - modern"), 
                              "belonging to an academy or institution for higher learning",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1886 - modern"), 
                              "not leading to a decision, unpractical, 
                                     theoretical, formal, or conventional",
                              h4("Noun", style = "text-align: center; color: navy;"),
                              tags$b("1.", style = "color: navy;"), 
                              tags$b("1586 - 1846"), tags$i("Obs."),
                              "an ancient philosopher of the Academy, 
                                     an adherent of the philosophical school of Plato, 
                                     a Platonist",
                              br(),
                              tags$b("2.", style = "color: navy;"), 
                              tags$b("1587 - modern"), 
                              "a senior member of the academic staff of a 
                                     college or university or a member of a society 
                                     for promoting art or science"
                     )
              ),
              infoBox("CEFR-level", "B2/C2", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˌæk.əˈdem.ɪk/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "academic.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/academic", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=academic&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cacademic%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
                     box(h4("Timeline", style = "text-align: center;"), 
                         width = 12,
                         timevisOutput("academ_tl")
                     )
            ),
            fluidRow(
                     tabBox(title = tagList(h4(tags$i("noun"))),
                            height = "90px",
                            width = 9,
                            tabPanel("Modern definition",
                                     style = "font-size: 17px; text-align: justify;",
                                     tags$b("1."),
                                     "someone who teaches at a college, 
                                     or who studies as part of their job"
                            )
                     ),
                     infoBox("CEFR-level", "C2", icon = icon("thumbs-up"), 
                             color = "yellow", width = 3
                     )
            ),
            fluidRow(
              box(width = 4,
                  img(src = "academic.jpg", height = 475,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(width = 8,style = "text-align: center;",
                  HTML('<iframe width="700" height="450" 
                       src="https://www.youtube.com/embed/fAClUtdMFlU?start=59" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )

    ),
    tabItem("edu_en",
            h2("Education"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "the process of teaching or learning, especially 
                              in a school or college, or the knowledge that you 
                              get from this",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "As a child he received most of 
                                              his education at home."),
                              tags$b("2."), tags$i("AmE. "),
                              "the study of methods and theories of teaching",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "She has a master’s degree in early 
                                              childhood education.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «education» (noun) was borrowed from Latin 
                              verb «ēducāre», which meant «bring up, rear» as well 
                              as more specifically «educate» and was related to 
                              «ēdūcere» «lead out».",
                              br(),
                              " The original metaphor was 
                              probably that of leading someone out of childhood 
                              and into the world. "),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The education system in the UK is divided into four 
                              main parts, primary education, secondary education, 
                              further education and higher education.",
                              br(), br(),
                              "Children in the UK have to legally attend primary 
                              and secondary education which runs from about 5 years 
                              old until the student is 16 years old."
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1531 - 1661"), tags$i("Obs."),
                              "the process of nourishing or rearing a child 
                              or young person, an animal",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1888"), tags$i("Spec."), 
                              " the rearing of silkworms",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1616 - modern"), 
                              "the systematic instruction, schooling or training 
                              given to the young in preparation for the work of life"
                     )
              ),
              infoBox("CEFR-level", "B1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˌedʒ.ʊˈkeɪ.ʃən/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "education.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/education", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=education&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Ceducation%3B%2Cc0#t1%3B%2Ceducation%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("edu_tl"))
            ),
            fluidRow(
              box(img(src = "education.jpg", height = 430,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                   src="https://www.youtube.com/embed/OV3tImRJVU8" 
                   title="YouTube video player" 
                   frameborder="0" allow="accelerometer; autoplay; 
                   clipboard-write; encrypted-media; gyroscope; 
                   picture-in-picture" allowfullscreen></iframe>')
              )
              
            )
            
    ),
    tabItem("ex_en", 
            h2("Examination"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."), tags$i("B2"),
                              "the act of looking at or considering something 
                              carefully in order to discover something",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "I had to have / undergo a medical examination 
                                              when I joined the pension scheme."),
                              tags$b("2."), tags$i("A2"),
                              "a formal test that you must pass in order to earn 
                              a particular qualification or to be allowed to do 
                              a particular job (an exam)",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "to take / pass / fail an examination")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «examination» (noun) was borrowed in Middle 
                              English from Old French «examiner» and Latin 
                              «examinare» «weigh, test», from «examen» literally 
                              «tongue of a balance».",
                              br(),
                              "The word’s use for «a test of knowledge» 
                              is recorded early in its history.   "
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The major national examinations in England, 
                              Northern Ireland, and Wales are the General 
                              Certificate of Secondary Education and the 
                              General Certificate of Education (GCE) Advanced 
                              Level (A level). In Scotland they are the Standard Grades, 
                              the Highers, and the Advanced Highers.",
                              br(), br(),
                              "These public examinations are externally assessed 
                              by external examiners, although schools and other 
                              institutions may set their own examinations. ",
                              br(), br(),
                              "The word «exam» as a college student slang shortened 
                              form of examination appeared in 1848. "
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1387 - 1861"), tags$i("Obs."),
                              "judicial inquiry into the guilt or innocence of 
                              an accused person by a standard or rule",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1510 - modern"), 
                              "the action of investigating the nature, qualities, 
                              or condition of any object by inspection or experiment",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1612 - modern"), 
                              "the process of testing, by questions oral or written, 
                              the knowledge or ability of pupils, or of candidates 
                              for office, degrees, etc."
                     )
              ),
              infoBox("CEFR-level", "A2/B2", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ɪɡˌzæm.ɪˈneɪ.ʃən/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "examination.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/examination", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=Examination&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2CExamination%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("exam_tl"))
            ),
            fluidRow(
              box(img(src = "exam.jpg", height = 380,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/q2UG9u-a7IM" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )
            
    ),
    tabItem("man_en", 
            h2("Manager"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "the person who is responsible for managing an 
                              organization or whose job is to organize sports 
                              team / singer / actor",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "a bank manager", 
                                              br(),
                                              "a station manager",
                                              br(),
                                              "a store manager",
                                              br(),
                                              "a football manager"),
                              tags$b("2."), tags$i("Spec."),
                              "computer program or system that helps you to 
                              control or organize a particular type of activity",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "You can click on a file in the file manager.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «manager» (noun) was borrowed from 
                              Italian «maneggiare», based on Latin «manus» «hand».",
                              br(),
                              "The early sense recorded for the verb «manage» was 
                              «put (a horse) through the paces of the manège» 
                              (= training in a enclosed area).  "
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The Education Reform Act 1988 resulted in a shift 
                              of much of the responsibility for the management 
                              of schools from the local authority to the schools 
                              themselves. This was known as Local Management of 
                              Schools (LMS).",
                              br(),br(),
                              "Part of the purpose for this reform
                              was to encourage market competition between schools. 
                              One notable consequence has been a growth in the use 
                              of business and management terminology within the 
                              education sector. ",
                              br(),br(),
                              " All this has been reflected in 
                              the range of professional development programmes 
                              and qualifications in the field of management which 
                              are now available to leaders and aspiring leaders 
                              of educational institutions. "
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1588 - modern"), 
                              "one whose office it is to manage a business 
                              establishment or a public institution",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1666 - 1863"), tags$i("Obs."),
                              "one of several members of either house of parliament 
                              appointed for the performance of some specified 
                              duty connected with the functions of the two houses",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1793 - 1880"), tags$i("Law."),
                              "a person appointed, ordinarily by a court of 
                              chancery, to control, carry on and account for 
                              any business which may have fallen into the hands 
                              of the court for the benefit of creditors or others"
                     )
              ),
              infoBox("CEFR-level", "A2", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˈmæn.ɪ.dʒər/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "manager.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/manager", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=manager&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cmanager%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("manag_tl"))
            ),
            fluidRow(
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/lDf9YHjnEi4" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )
            
    ),
    tabItem("prof_en", 
            h2("Professional"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("adjective"))),
                     height = "370px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."), tags$i("B2"),
                              "relating to work that needs special 
                              training or education ",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "Chris, you're a nurse, so can I 
                                              ask your professional opinion 
                                              on bandaging ankles?"),
                              tags$b("2."), tags$i("B1"),
                              "having the qualities that you connect with 
                              trained and skilled people, such as effectiveness, 
                              skill, organization, and seriousness of manner",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "She always looks very professional 
                                              in her smart suits."),
                              tags$b("3."), tags$i("B1"),
                              "used to describe someone who does a job 
                              that people usually do as a hobby",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "She's a professional dancer.",
                                              br(),
                                              "a professional photographer.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «professional» (adjective + noun) was 
                              borrowed from «prōfessus», the past participle of 
                              Latin «profitēri» «to declare publicly».",
                              br(), br(),
                              "A «professor» is etymologically someone who 
                              «makes a public claim» to knowledge in a particular 
                              field; and someone’s «profession» is the area of 
                              activity in which they «profess» a skill or competence."
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Adjective", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1420 - 1881"), tags$i("Obs."),
                              "pertaining to or marking entrance into a religious order",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1747 - modern"), 
                              "engaged in one of the learned or skilled professions, 
                              or in a calling considered socially superior to 
                              a trade or handicraft",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1879 - 1978"), 
                              "disparagingly applied to one who pursues 
                              relentlessly an activity or belief that is 
                              regarded with disfavour; inveterate, habitual, ruthless",
                              h4("Noun", style = "text-align: center; color: navy;"),
                              tags$b("1.", style = "color: navy;"), 
                              tags$b("1848 - modern"), 
                              "one who belongs to one of the learned or 
                              skilled professions",
                              br(),
                              tags$b("2.", style = "color: navy;"), 
                              tags$b("1811 - modern"), 
                              "one who makes a profession or business of any 
                              occupation, art, or sport, otherwise usually or 
                              often engaged in by amateurs as a pastime",
                              br(),
                              tags$b("3.", style = "color: navy;"), 
                              tags$b("1861 - 1977"), 
                              "a prostitute"
                     )
              ),
              infoBox("CEFR-level", "B1/B2", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/prəˈfeʃ.ən.əl/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "professional.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/professional", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=professional&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cprofessional%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("prof_tl"))
            ),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 9,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."), tags$i("C1"),
                              "a person who has the type of job that needs 
                              a high level of education and training",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "health professionals"),
                              tags$b("2."), tags$i("C1. Informal."),
                              "someone who has worked hard in the same type of 
                              job for a long time and has become skilled at 
                              dealing with any problem that might happen",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "I thought the whole meeting was 
                                              going to fall apart but you rescued 
                                              it like a true professional!"),
                              tags$b("3."), tags$i("B2"),
                              "a person who does a job that people usually do as a hobby",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "He's only been playing football 
                                              as a professional for two years.")
                     )
              ),
              infoBox("CEFR-level", "B2/C1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 3
              )
            )
    ),
    tabItem("schol_en", 
            h2("School"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "700px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."), tags$i("A1"),
                              "a place where children go to be educated or 
                              a where people can study a particular subject ",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "a primary school",
                                              br(),
                                              "a secondary school", 
                                              br(),
                                              "a driving school",
                                              br(),
                                              "a dancing school"),
                              tags$b("2."), tags$i("A2"),
                              "a part of a college or university specializing 
                              in a particular subject or group of subjects",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "the School of Oriental and African Studies"),
                              tags$b("3."), tags$i("B1"),
                              "a group of painters, writers, poets, etc. whose 
                              work is similar, especially similar to that of 
                              a particular leader",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                                              "the Impressionist school of painting")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «school» (noun) was developed from Old 
                              English «scōl, scolu» «place for instruction» 
                              that came via Latin from Greek «skholē» «leisure, 
                              philosophy, lecture-place». ",
                              br(),
                              "This originally 
                              denoted «leisure», and only gradually developed 
                              through «leisure used for intellectual argument 
                              or education» and finally «school» «the building»."
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "1. Christian missionaries established schools 
                              throughout Europe, and St. Augustine of Canterbury 
                              is said to have established the first English school 
                              in 598.",
                              br(),
                              "The first school known to have been designated 
                              as ‘High School’ in Great Britain was established 
                              in Edinburgh in 1519.",
                              br(),br(),
                              "2. Schools in Britain as educational 
                              institutions may be identified according to the 
                              age of the pupils: pre-schools/nursery schools/
                              infant schools/junior schools (collectively termed 
                              primary schools), and secondary schools.",
                              br(),
                              "They may also be identified according to whether 
                              they are maintained (state) schools, academies, 
                              or public (private, fee-charging) schools. Secondary 
                              schools may be designated grammar schools or 
                              comprehensive schools. Schools which are supported 
                              by recognized religious organizations are known as 
                              faith or denominational schools; and those with 
                              sponsorship from industry and commerce are called 
                              trust schools.",
                              br(),br(),
                              "3. At Oxford University the word «school» can 
                              refer to a course leading to a first degree, and 
                              to all those who work within that subject. 
                              And in the U.S. it is often used to designate 
                              either a department devoted to one subject or 
                              a grouping of several subject departments.",
                              br(),br(),
                              "4. Early on the word “school” was confused with 
                              the Dutch word “schole” «crowd, multitude», 
                              which went on to become English “shoal” «multitude 
                              (of fish)». The upshot of this confusion was that 
                              the phrase, “school of fish”, became more popular 
                              in the US than the original “shoal of fish”. "
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1000 - modern"), 
                              "an institution in which instruction of any kind 
                              is given (whether to children or adults)",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1375 - 1781"), tags$i("Obs."), 
                              "the place in which an ancient Greek or Roman 
                              philospher taught his hearers",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1612 - modern"), 
                              "the body of persons that are or have been taught 
                              by a particular master (in philosophy, science, art, etc.)",
                              br(),
                              tags$b("4.", style = "color: green;"), 
                              tags$b("1812 - 1976"), tags$i("Slang"),
                              "a company of thieves or beggars working together",
                              br(),
                              tags$b("5.", style = "color: green;"), 
                              tags$b("1890 - 1971"), tags$i("Slang"),
                              "a group of persons drinking together in a bar or 
                              public house, and taking turns to buy the drinks.",
                              br(),
                              tags$b("6.", style = "color: green;"), 
                              tags$b("1400 - modern"), 
                              "the faculties composing a college or university, 
                              universities in general",
                              br(),
                              tags$b("7.", style = "color: green;"), 
                              tags$b("1614 - 1684"), tags$i("Obs."), 
                              "the scholastic philosophers and theologians 
                              collectively (the School, the Schools, the Schoolmen)",
                              br(),
                              tags$b("8.", style = "color: green;"), 
                              tags$b("1828 - modern"), 
                              "the periodical examinations for the degree 
                              of B.A. at Oxford University",
                              br(),
                              tags$b("9.", style = "color: green;"), 
                              tags$b("816 - 1450"), tags$i("Obs."),
                              "a hostelry at Rome for the reception of pilgrims",
                              br(),
                              tags$b("10.", style = "color: green;"), 
                              tags$b("1400 - 1601"), tags$i("Obs."),
                              "a public building, gallery, or the like",
                              br(),
                              tags$b("11.", style = "color: green;"), 
                              tags$b("1892"), 
                              "a cross-country ride",
                              h4("Verb", style = "text-align: center; color: navy;"),
                              tags$b("1.", style = "color: navy;"), 
                              tags$b("1573 - modern"), 
                              "to educate, train (a person, his mind, powers, 
                              tastes, etc.)",
                              br(),
                              tags$b("2.", style = "color: navy;"), 
                              tags$b("1592 - 1628"), 
                              "to give a lesson to (a person) by punishment, to chastise",
                              br(),
                              tags$b("3.", style = "color: navy;"), 
                              tags$b("1869 - modern"), 
                              "to train or exercise (a horse) in movements. ",
                              br(),
                              tags$b("4.", style = "color: navy;"), 
                              tags$b("1885"), 
                              "to ride straight across country",
                              br(),
                              tags$b("5.", style = "color: navy;"), 
                              tags$b("1902"),
                              "to rear (a plant) in a nursery"
                     )
              ),
              infoBox("CEFR-level", "A1/A2/B1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/skuːl/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "school.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/school", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=school&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cschool%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("school_tl"))
            ),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("verb"))),
                     height = "140px",
                     width = 9,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "to train a person or animal to do something",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "It takes a lot of patience to school a dog / horse.")
                     )
              ),
              infoBox("CEFR-level", "B1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 3
              )
            ),
            fluidRow(
              box(img(src = "school.jpg", height = 285,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/zmvbSoO0Qq4" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )
            
    ),
    tabItem("sci_en",
            h2("Science"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "(knowledge from) the careful study of the 
                              structure and behaviour of the world, especially 
                              by doing experiments",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "Space travel is one of the wonders of modern science.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «science» (noun) was borrowed from 
                              Old French “scientia”, from Latin “scīre” «know»."
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "Originally science was knowledge in general, or 
                              any branch of knowledge, including the arts. 
                              The restricted modern sense of science, 
                              concentrating on the physical and natural world, 
                              dates from the 18th century.",
                              br(),
                              "In the Middle Ages, “the seven (liberal) sciences” 
                              was often used synonymously with “the seven liberal arts”, 
                              for the group of studies comprised by the Trivium 
                              (Grammar, Logic, Rhetoric) and the Quadrivium 
                              (Arithmetic, Music, Geometry, Astronomy).",
                              br(),br(),
                              "The derivative “scientist” was coined in 1840 by 
                              William Whewell:",
                              br(),
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;",
                              "‘We need very much a name to 
                              describe a cultivator of science in general. 
                              I should incline to call him a Scientist.’")
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1289 - modern"), 
                              "knowledge acquired by study, acquaintance with 
                              or mastery of any department of learning",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1588 - 1839"), tags$i("Slang"),
                              "The noble science (of defence): the art of boxing 
                              or that of fencing",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1480 - 1660"), tags$i("Obs."),
                              "a craft, trade, or occupation requiring 
                              trained skill"
                     )
              ),
              infoBox("CEFR-level", "A2", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˈsaɪ.əns/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "science.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/science", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=science&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cscience%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("sci_tl"))
            ),
            fluidRow(
              box(img(src = "sci_ru.jpg", height = 325,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/YvtCLceNf30" 
                       title="YouTube video player" frameborder="0" 
                       allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>')
              )
            )
            
    ),
    tabItem("stud_en", 
            h2("Student"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition", 
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "a person who is learning at a school, 
                              college or university",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "Teachers use a variety of materials 
                                              to inspire their students.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «student» (noun) was borrowed via Old 
                              French “estudie” from Latin “stadium” «zeal, 
                              painstaking application» hence «application to 
                              learning». ",
                              br(),br(),
                              "This probably went back ultimately 
                              to the Indo-european base “*steud-, *teud-” «hit», 
                              which also produced Latin “tundere” «hit» (source 
                              of English “contusion” and “obtuse”) and German 
                              “stossen” «shove, hit» – the underlying notion 
                              of “study” thus being the «application of extreme effort»."
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «student» is usually used in the tertiary 
                              sector at college or university, those enrolled 
                              in primary/elementary schools are called «pupils», 
                              although it is not unusual to refer to older pupils 
                              in schools as ‘students’, too.",
                              br(),br(),
                              " In the United States for high school and 
                              university, the students are 
                              named according to the year of studying:",
                              br(),
                              tags$b("1st year"), "– freshman",
                              br(),
                              tags$b("2nd year"), "– sophomore",
                              br(),
                              tags$b("3rd year"), "– junior", 
                              br(),
                              tags$b("4th year"), "– senior."
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1398 - modern"),
                              "a person who is undergoing a course of study and 
                              instruction at a university or other place of 
                              higher education or technical training",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1936 - 1951"),  tags$i("U.S. Drug-users' slang "),
                              "an inexperienced user of illegal drugs, one who 
                              takes small or occasional doses",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1651 - 1858"), tags$i("Spec."),
                              "At Christ Church, Oxford: a member of the 
                              foundation, corresponding to the ‘fellow’ or 
                              ‘scholar’ of other colleges"
                     )
              ),
              infoBox("CEFR-level", "A1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˈstjuː.dənt/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "student.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/student", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=student&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cstudent%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("stud_tl"))
            ),
            fluidRow(
              box(img(src = "students.jpg", height = 380,
                      style = "display: block; margin-left: auto; margin-right: auto;")),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/NDTSny32n70" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )
            
    ),
    tabItem("teach_en", 
            h2("Teacher"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "someone whose job is to teach in a school or college",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "The teacher drew a diagram 
                                              showing how the blood flows 
                                              through the heart.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «teacher» (noun) goes back ultimately 
                              to the prehistoric Indo-European base “*deik-” 
                              shared by Greek «deiknunai» «show» and Latin 
                              «dīcere» «say» (source of English diction, 
                              dictionary, etc.). ",
                              br(),
                              " Old English “tǣcan” meant 
                              «to show, point out, declare, demonstrate». 
                              from Proto-Germanic «*taikijan» «to show» 
                              an Indo-European root"
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "Although most usually referring to one who teaches 
                              in a school, the title of ‘teacher’ also applies 
                              in a wider context to include professionals in 
                              other educational institutions, as well as those 
                              working outside such institutions who nevertheless 
                              have a pedagogical role, such as giving instruction 
                              in the playing of a musical instrument. ",
                              br(),
                              "Thus, ‘teacher’ 
                              may be taken to cover a range of more specific terms 
                              which, as well as ‘lecturer’, include ‘trainer’, 
                              ‘instructor’, and ‘tutor’. "
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1290 - 1350"), tags$i("Obs."),
                              "that which shows or points out, an indicator, 
                              the index-finger",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1375 - modern"), 
                              "one who teaches or instructs at school",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1834"), tags$i("Spec."),
                              "formerly, in New England Congregational churches, 
                              one of several officers appointed to teach" 
                     )
              ),
              infoBox("CEFR-level", "A1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", "/ˈtiː.tʃər/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "teacher.mp3", type = "audio/mp3", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/teacher", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=teacher&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cteacher%3B%2Cc0#t1%3B%2Cteacher%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("teach_tl"))
            ),
            fluidRow(
              box( img(src = "teach_ru.jpg", height = 335,
                       style = "display: block; margin-left: auto; margin-right: auto;")
              ),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/FY5HIgpIyig" 
                       title="YouTube video player" 
                       frameborder="0" allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>'))
            )
            
    ),
    tabItem("uni_en", 
            h2("University"),
            fluidRow(
              tabBox(title = tagList(h4(tags$i("noun"))),
                     height = "330px",
                     width = 7,
                     tabPanel("Modern definition",
                              style = "font-size: 17px; text-align: justify;",
                              tags$b("1."),
                              "a place of higher education where people study 
                              for an undergraduate (= first) or postgraduate 
                              (= higher level) degree",
                              tags$blockquote(style = "text-align: right; 
                                             background-color: #dbfac3; font-style: italic; 
                                             font-size: 15px;", 
                                              "She applied to six universities 
                                              and was accepted by three.")
                     ),
                     tabPanel("Etymology", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "The word «university» (noun) is a Middle English 
                              adaptation of French “université”, derived from 
                              Medieval Latin “universitas” «society, community».",
                              br(),br(),
                              "Its current use resulted from a shortening of 
                              the original phrase, “universitas magistrorum et 
                              scholarium” «community of masters and scholars». 
                              The base is Latin “universus” «combined into one»."
                     ),
                     tabPanel("Cultural comment", 
                              style = "outline-style: dotted; text-align: justify; outline-color: #5dbb63; outline-offset: 5px; font-size: 17px;",
                              "1. The first universities to be established in 
                              England were Oxford and Cambridge, which were both 
                              founded in the 13th century. In Scotland, St Andrews, 
                              Aberdeen, and Glasgow were the earliest, dating 
                              back to the 15th century; Edinburgh was established 
                              in 1582.  ",
                              br(),
                              "Following the Second World War, there was 
                              a very rapid expansion, including the founding of 
                              the universities of York, Warwick, and Lancaster 
                              in the 1960s. These universities were known as",
                              tags$b("‘new universities’"),
                              "to distinguish them from the 
                              older institutions such as Oxford, Cambridge, 
                              Glasgow, and Durham, and the",
                              tags$b("red-brick universities"), 
                              "founded at the turn of the century.",
                              br(),br(),
                              "2. The phrase «alma mater», used with reference to 
                              a university or college once attended appeared 
                              in the 17th century, and first had the general 
                              sense ‘someone or something providing nourishment’. 
                              It was a title given by the Romans to several 
                              goddesses but in particular to Ceres and Cybele, 
                              both representing fostering mother-figures."
                     ),
                     tabPanel("Timeline", 
                              style = "font-size: 17px; text-align: justify;",
                              h4("Noun", style = "text-align: center; color: green;"),
                              tags$b("1.", style = "color: green;"), 
                              tags$b("1300 - modern"), 
                              "the whole body of teachers and scholars engaged, 
                              at a particular place, in giving and receiving 
                              instruction in the higher branches of learning",
                              br(),
                              tags$b("2.", style = "color: green;"), 
                              tags$b("1374 - 1843"), 
                              "the whole of something, all things, etc. 
                              A body or company of persons associated 
                              together for some purpose",
                              br(),
                              tags$b("3.", style = "color: green;"), 
                              tags$b("1494 - 1642"), tags$i("Obs."),
                              "the universe, = universality "
                     )
              ),
              infoBox("CEFR-level", "A1", icon = icon("thumbs-up"), 
                      color = "yellow", width = 5
              ),
              infoBox("Pronunciation", " /ˌjuː.nɪˈvɜː.sə.ti/", icon = icon("volume-up"), 
                      color = "green", width = 5,
                      tags$audio( src = "university.ogg", type = "audio/ogg", 
                                  autoplay = FALSE, controls = TRUE)
              ),
              infoBox("Examples", "Linguazza.com discovery tool", icon = icon("stream"), 
                      color = "olive", width = 5,
                      tags$a(href = "https://linguazza.com/phrases-with/university", 
                             target="_blank", "Click here!")
              ),
              infoBox("Usage", "Google Books Ngram Viewer", icon = icon("google"), 
                      color = "lime", width = 5,
                      tags$a(href = "https://books.google.com/ngrams/graph?content=university&year_start=1800&year_end=2019&corpus=26&smoothing=3&direct_url=t1%3B%2Cuniversity%3B%2Cc0", 
                             target="_blank", "Click here!")
              )
            ),
            fluidRow(
              box(h4("Timeline", style = "text-align: center;"),
                  width = 12,
                  timevisOutput("uni_tl"))
            ),
            fluidRow(
              box(img(src = "university.jpg", height = 380,
                      style = "display: block; margin-left: auto; margin-right: auto;")
              ),
              box(style = "text-align: center;",
              HTML('<iframe width="500" height="315" 
                       src="https://www.youtube.com/embed/lWz-46NPqdk" 
                       title="YouTube video player" frameborder="0" 
                       allow="accelerometer; autoplay; 
                       clipboard-write; encrypted-media; gyroscope; 
                       picture-in-picture" allowfullscreen></iframe>')
              )
            )
    ),
    tabItem("about", 
            fluidRow(
              box(width = 12,
                  style = "font-size: 15px; text-align: justify;",
                  h3("About | О словаре", style = "color: green; text-align: center;"),
                  "Настоящее приложения является",
                  tags$b("моделью"),
                  tags$i("компьютерного мультимодального учебного словаря 
                  историко-культурологического типа,"),
                  "разработанного в качестве визуализации результатов
                  научного исследования по подготовке диссертации на соискание 
                  ученой степени кандидата филолологических наук по специальности:",
                  br(),
                  tags$b("10.02.20"),
                  tags$i("— Сравнительно-историческое типологическое и 
                  сопоставительное языкознание."),
                  br(),br(),
                  tags$b("Тема исследования:"),
                  "«Семантизация историко-культурного компонента 
                  в учебном мультимодальном словаре
                  (на материале русского/английского языков)».",
                  br(),br(),
                  tags$blockquote(style = "background-color: #dbfac3; 
                  font-size: 15px; text-align: right;",
                  tags$b("Автор:"),
                  "Башмакова Анастасия Юрьевна", 
                  br(),
                  tags$i("stukalovaanastasia [at] gmail.com"),
                  br(),br(),
                  tags$b("Научный руководитель:"),
                  "Дрожащих Наталия Владимировна,",
                  tags$i("д-р филол. наук, доц."),
                  br(),br(),
                  "ФГАОУ ВО «Тюменский государственный университет»"),
                  "Дополнительные материалы исследования расположены в репозитории GitHub ",
                  tags$a(href = "https://github.com/nastuk/dissertation", 
                         target="_blank", "по ссылке.")
                  ),
              box(width = 9,
                  style = "font-size: 15px; list-style-type: square;",
                  h4("Список сокращений ", style = "color: green; 
                     text-align: center;"), 
                  tags$div(style = "column-count: 3;",
                  tags$li(tags$i("др.-греч."),"- древнегреческий язык"),
                  tags$li(tags$i("др.-русск."),"- древнерусский язык"),
                  tags$li(tags$i("жен. род"),"- женский род"),
                  tags$li(tags$i("лат."),"- латинский язык"),
                  tags$li(tags$i("муж. род"),"- мужской род"),
                  tags$li(tags$i("неодуш."),"- неодушевленный"),
                  tags$li(tags$i("одуш."),"- одушевленный"),
                  tags$li(tags$i("праиндоевр."),"- праиндоевропейский язык"),
                  tags$li(tags$i("праслав."),"- праславянский язык"),
                  tags$li(tags$i("прич."),"- причастие"),
                  tags$li(tags$i("разг."),"- народно-разговорное"),
                  tags$li(tags$i("русск.церк.слав."),"- церковнославянский язык"),
                  tags$li(tags$i("скл."),"- склонение"),
                  tags$li(tags$i("ср. род"),"- средний род"),
                  tags$li(tags$i("сущ."),"- существительное"),
                  tags$li(tags$i("устар."),"- устаревшее")
                  ),
              ),
              box(width = 3,
                  style = "font-size: 16px; list-style-type: square;",
                  h4("List of Abbreviations", style = "color: green; 
                     text-align: center;"),
                  tags$li(tags$i("AmE"),"- American English"), 
                  tags$li(tags$i("Obs."),"- obsolete"),
                  tags$li(tags$i("Spec."),"- specialized"),
                  tags$li(tags$i("U.S."),"- United States"),
                  br()
              ),
              box(width = 12,
                  style = "font-size: 16px; text-align: justify;",
                  h4("Timeline", style = "color: green; text-align: center;"),
                  "The",
                  tags$b("Timeline "),
                  "section of the English part of the dictionary consists of two fields:",
                  tags$i("Text Interpretation"),
                  "(pic.1) and ",
                  tags$i("Vizualization"),
                  "(pic.2).",
                  br(),
                  "The definitions in the Timeline tab are 
                  highlighted in separate colours for different parts of speech 
                  (green and blue). The dates of the word meaning usage are in bold. 
                  Stylistic labels, if any, are in italics. The number of the definition
                  in the text corresponds to the number of the block located on the Timeline, 
                  coloured according to the part of speech.",
                  br(), br(),
                  tags$div(style = "font-size: 15px; text-align: justify;",
                           "Секция",
                           tags$b("Timeline "),
                           "английской части словаря состоит из двух полей:",
                           tags$i("Исторические значения слова"),
                           "(рис.1) и ",
                           tags$i("Визуализация временной шкалы"),
                           "(рис.2).",
                           br(),
                           "Определения значений на вкладке Timeline отмечены цветами 
                  для разных частей речи (зеленый и синий). Жирным шрифтом выделены 
                  даты употребления того или иного исторического значения слова. 
                  Стилистические пометы, если таковые имеются, выделены курсивом. 
                  Номер значения в тексте соответствует номеру блока, расположенного 
                  на временной шкале, окрашенного в соответствии с частью речи."
                  ),
                  br(), br(),
                  tags$div(
                  box(h5(tags$b("pic.1"), "Text Interpretation ", 
                         style = "text-align: center;"),
                    img(src = "tl_text.png", width = 475, 
                          style = "display: block; margin-left: auto; margin-right: auto;"),
                    tags$div(tags$b("рис.1"), "Исторические значения слова",
                             style = "font-size: 14px; text-align: center;")
                  ),
                  box(h5(tags$b("pic.2"), "Vizualization ", 
                         style = "text-align: center;"),
                    img(src = "tl_viz.png", width = 480,
                          style = "display: block; margin-left: auto; margin-right: auto;"),
                    br(), br(), br(),
                    tags$div(tags$b("рис.2"), "Визуализация временной шкалы",
                             style = "font-size: 14px; text-align: center;")        
                  )
                  )
              ),
              box(width = 12,
                  style = "font-size: 15px; text-align: justify;",
                  h4("Disclaimer", style = "color: navy; text-align: center;"),
                  "Настоящий словарь предоставляет информацию о значениях и 
                  употреблении слов и словосочетаний только в учебных и 
                  информационных целях в соответствии с принципом 
                  свободного (добросовестного) использования (ГК РФ Статья 1274).
                  Все использованные в словарных статьях цитаты, изображения и 
                  видео являются собственностью их законных владельцев. 
                  Пожалуйста, ознакомьтесь со списоком использованных источников
                  и словарей для русского и английского языков ниже.",
                  br(),br(),
                  tags$div(style = "font-size: 16px;",
                  "This dictionary presents information about word definitions 
                  and phrase usages for educational and informational purposes 
                  only in accordance with fair use principle. 
                  All above text quotes, images and videos are in ownership 
                  of their legal owners. 
                  Please, look at the list of references and dictionaries of 
                  the Russian and English languages below to get to 
                  the original source.")
              ),
              box(width = 6,
                  style = "font-size: 15px; list-style-type: square;",
                  h4("References", style = "color: green; text-align: center;"),
                  tags$li("Oxford English Dictionary"),
                  tags$li("Cambridge Advanced Learner's Dictionary"),
                  tags$li("Merriam-Webster: Dictionary and Thesaurus"),
                  tags$li("The Oxford Dictionary of Word Histories"),
                  tags$li("Arcade Dictionary of Word Origins by John Ayto"),
                  tags$li("The Oxford Dictionary of Word Origins (2 ed.) edited by Julia Cresswell"),
                  tags$li("The Merriam-Webster New Book of Word Histories"),
                  tags$li("A Dictionary of Education (2 ed.) Susan Wallace"),
                  tags$li("Online Etymology Dictionary"),
                  tags$li("Dr. Goodword AlphaDictionary")
              ),
              box(
                width = 6,
                style = "font-size: 14px; list-style-type: square;",
                h4("Источники", style = "color: green; text-align: center;"),
                tags$li("Большой толковый словарь русского языка С.А Кузнецова"),
                tags$li("Морфемно-орфографический словарь А.Н. Тихонова"),
                tags$li("Этимологический словарь современного русского языка М. Фасмера"),
                tags$li("Этимологический словарь современного русского языка А.К. Шапошникова"),
                tags$li("Этимологический словарь русского языка: Русский язык от А до Я"),
                tags$li("Этимологический словарь русского языка Г.А. Крылова"),
                tags$li("«Грамота.ру»"),
                tags$li("«Академик. Словари и энциклопедии»"),
                tags$li("Новый словарь методических терминов и понятий (теория и практика обучения языкам)"),
                tags$li("Энциклопедия русской цивилизации")
              )
            )
    )
  )
)

ui <- dashboardPage(skin = "green", header, sidebar, body)

server <- function(input, output){
  output$res <- renderText({
    req(input$sidebarItemExpanded)
  })
  output$wordcloud_en <- renderWordcloud2({
    wordcloud2(data = en_freq, color="random-dark", 
               fontFamily= 'Calibri', backgroundColor= "#e9f0f2", 
               shape = 'circle')
  })
  output$wordcloud_ru <- renderWordcloud2({
    wordcloud2(data = ru_freq, size=4, color="random-dark", 
               fontFamily= 'Calibri', backgroundColor= "#e9f0f2", 
               shape = 'circle')
  })
  output$academ_tl <- renderTimevis({
    timevis(academ)
  })
  output$edu_tl <- renderTimevis({
    timevis(edu)
  })  
  output$exam_tl <- renderTimevis({
    timevis(exam)
  })
  output$manag_tl <- renderTimevis({
    timevis(manag)
  })
  output$prof_tl <- renderTimevis({
    timevis(prof)
  })
  output$school_tl <- renderTimevis({
    timevis(school)
  })
  output$stud_tl <- renderTimevis({
    timevis(stud)
  })  
  output$sci_tl <- renderTimevis({
    timevis(sci)
  })
  output$teach_tl <- renderTimevis({
    timevis(teach)
  })
  output$uni_tl <- renderTimevis({
    timevis(uni)
  })  
}

shinyApp(ui, server)

