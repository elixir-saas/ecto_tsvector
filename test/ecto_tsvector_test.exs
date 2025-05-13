defmodule EctoTsvectorTest do
  use EctoTsvector.RepoCase

  import EctoTsvector.Query

  describe "simple" do
    setup do: setup_search_items()

    test "results when search term has matches" do
      assert search_match_count("dolor") == 3
    end

    test "no results when search term has no matches" do
      assert search_match_count("nothing") == 0
    end

    test "results with phrase" do
      assert search_match_count("quia voluptas sit") == 1
    end
  end

  describe "en" do
    setup do: setup_search_items("en")

    test "results when search term has matches" do
      assert search_match_count("relentless") == 2
    end

    test "no results when search term has no matches" do
      assert search_match_count("nothing") == 0
    end

    test "results with phrase" do
      assert search_match_count("we're your partner") == 1
    end

    test "results with close matches" do
      assert search_match_count("deliver") == 2
    end
  end

  describe "fr" do
    setup do: setup_search_items("fr")

    test "results when search term has matches" do
      assert search_match_count("vitesse") == 1
    end

    test "no results when search term has no matches" do
      assert search_match_count("rien") == 0
    end

    test "results with phrase" do
      assert search_match_count("fournissant des informations exploitables") == 1
    end

    test "results with close matches" do
      assert search_match_count("fournir") == 2
    end
  end

  ## Helpers

  def search_match_count(term) do
    items =
      SearchItem
      |> tsvector_search_query(term, language_field: :lang)
      |> TestRepo.all()

    length(items)
  end

  def setup_search_items(language \\ nil) do
    pg_language =
      if language do
        EctoTsvector.Dictionary.language_code_to_postgres!(language)
      end

    language
    |> text_lines()
    |> String.trim()
    |> String.split("\n")
    |> Enum.each(fn line ->
      TestRepo.insert!(%SearchItem{text: line, lang: pg_language})
    end)
  end

  def text_lines(nil) do
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
    Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
    Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.
    Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?
    """
  end

  def text_lines("en") do
    """
    At our core, we empower scalable solutions that drive cross-functional alignment and unlock next-generation growth.
    By leveraging a holistic ecosystem of tools, we enable organizations to optimize performance at every touchpoint.
    Our agile framework ensures end-to-end visibility, allowing stakeholders to proactively identify opportunities and mitigate risks in real time.
    Through a customer-centric lens, we reimagine legacy workflows and streamline complex operations with cloud-native precision.
    Our platform integrates seamlessly with your existing stack, delivering actionable insights and measurable ROI from day one.
    We're committed to transforming data into impact and friction into flow.
    With a relentless focus on innovation, we future-proof your business by delivering high-velocity outcomes at scale.
    Our team partners with industry leaders to co-create bespoke strategies that meet the evolving needs of dynamic markets.
    Whether you're scaling up or pivoting fast, we're your partner in transformation.
    Built on a foundation of trust, transparency, and continuous improvement, we cultivate meaningful relationships that drive long-term value.
    Our mission is simple: to enable growth through smart technology, empathetic design, and relentless execution.
    Together, we turn challenges into catalysts.
    Let’s accelerate your digital evolution.
    From ideation to implementation, we provide the clarity and confidence you need to lead in a competitive landscape.
    Because in today’s world, velocity is value — and we’re here to help you move forward, faster.
    """
  end

  def text_lines("fr") do
    """
    Au cœur de notre mission, nous favorisons des solutions évolutives qui stimulent l’alignement transversal et libèrent une croissance de nouvelle génération.
    En exploitant un écosystème holistique d’outils, nous permettons aux organisations d’optimiser leur performance à chaque point de contact.
    Notre cadre agile garantit une visibilité de bout en bout, permettant aux parties prenantes d’identifier de manière proactive les opportunités et de réduire les risques en temps réel.
    À travers une approche centrée sur le client, nous réinventons les processus hérités et rationalisons les opérations complexes avec la précision du cloud natif.
    Notre plateforme s’intègre parfaitement à votre infrastructure existante, fournissant des informations exploitables et un retour sur investissement mesurable dès le premier jour.
    Nous nous engageons à transformer les données en impact et les frictions en fluidité.
    Grâce à un engagement constant en faveur de l’innovation, nous préparons votre entreprise à l’avenir en fournissant des résultats rapides à grande échelle.
    Notre équipe collabore avec les leaders du secteur pour co-créer des stratégies sur mesure répondant aux besoins évolutifs de marchés dynamiques.
    Que vous soyez en phase d’accélération ou en pleine réorientation, nous sommes votre partenaire de transformation.
    Fondés sur la confiance, la transparence et l’amélioration continue, nous cultivons des relations solides qui génèrent une valeur durable.
    Notre mission est simple : favoriser la croissance grâce à une technologie intelligente, un design empathique et une exécution sans relâche.
    Ensemble, nous transformons les défis en leviers de changement.
    Accélérons votre évolution numérique.
    De l’idéation à la mise en œuvre, nous vous apportons la clarté et la confiance nécessaires pour prendre la tête dans un environnement concurrentiel.
    Car dans le monde d’aujourd’hui, la vitesse est synonyme de valeur — et nous sommes là pour vous aider à avancer, plus vite.
    """
  end
end
