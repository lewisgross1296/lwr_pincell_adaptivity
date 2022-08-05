[Mesh]
  [file]
    type = FileMeshGenerator
    file = mesh_in.e
  []

  allow_renumbering = false
[]

[AuxVariables]
  [cell_id]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_instance]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_temperature]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [cell_id]
    type = CellIDAux
    variable = cell_id
  []
  [cell_instance]
    type = CellInstanceAux
    variable = cell_instance
  []
  [cell_temperature]
    type = CellTemperatureAux
    variable = cell_temperature
  []
[]

[Problem]
  type = OpenMCCellAverageProblem
  verbose = true
  power = ${fparse 3000e6 / 273 / (17 * 17)}
  solid_blocks = '1 2 3'
  tally_type = mesh
  normalize_by_global_tally = false
  check_zero_tallies = false
  solid_cell_level = 0

  particles = 10000
  inactive_batches = 500
  batches = 1500
[]

[Adaptivity]
  # uncomment and change active blocks if it will be desired to exclude blocks from adaptivity
  # active = '1 2 3'
  max_h_level = 3
  cycles_per_step = 1
  marker = error_tol_marker
  [Indicators]
    [heat_source_value_jump]
      type = ValueJumpIndicator
      variable = heat_source
    []
  []
  [Markers]
    [error_tol_marker]
      type = ErrorToleranceMarker
      coarsen = 5e-8
      refine = 1e-6
      indicator = heat_source_value_jump
    []
  []
[]

[Executioner]
  type = Transient
[]

[Outputs]
  exodus = true
[]

[Postprocessors]
  [heat_source]
    type = ElementIntegralVariablePostprocessor
    variable = heat_source
  []
  [max_tally_rel_err]
    type = FissionTallyRelativeError
  []
  [max_heat_source]
    type = ElementExtremeValue
    variable = heat_source
  []
[]
