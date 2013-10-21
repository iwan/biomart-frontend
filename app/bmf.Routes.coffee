bmf.Routes = Routes =
  gene_retrieval:     "gene_retrieval"
  variant_retrieval:  "variant_retrieval"
  sequence_retrieval: "sequence_retrieval"
  id_converter:       "id_converter"

bmf.root = root = "/"

bmf.Paths =
  gene_retrieval:     -> root + Routes.gene_retrieval
  variant_retrieval:  -> root + Routes.variant_retrieval
  sequence_retrieval: -> root + Routes.sequence_retrieval
  id_converter:       -> root + Routes.id_converter
