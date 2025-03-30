# HAND Simulation

This repository compiles the files and outlines the procedures for verifying the simulation of the HAND Power Delivery Network using ORCAD.

## Software Requirements

- ORCAD ≥ 2022
- MATLAB ≥ 2023a

## Hardware Information

- Intel I9-10900F
- 32 GB RAM
- Data Size $\approx$ 25 GB

The simulation process takes approximately **6** hours.

## Results

![hand_pdn_sim](pictures/hand_pdn_sim.png)

The above figure demonstrates that under normal operating conditions, the HAND power system consistently outputs 3.3V and 5V.

## Data Visualization

### How to Plot the Results in PSPICE?

After you simulate the circuit, perform the following steps:

1. Window ➞ Display Control

   ![display_control](pictures/display_control.png)

2. Choose an existing `hand_pdn` or load `hand_pdn_v2-PSpiceFiles\SCHEMATIC1\hand_pdn_v2\hand_pdn_v2.prb`

   ![hand_pdn_prb](pictures/hand_pdn_prb.png)

3. Ensure you're using the correct data file ( `hand_pdn_v2.dat` )
4. View the plotted result

   ![result_in_pspice](pictures/result_in_pspice.png)

## How to Convert .dat to .mat?

### Export

1. Select the MATLAB path

   ![select_matlab_path](pictures/select_matlab_path.png)

2. Export the selected traces

   ![export_selected_traces](pictures/export_selected_traces.png)

3. Choose specific traces (do not export all traces, as it takes an excessively long time) and click export

   ![select_specific_traces](pictures/select_specific_traces.png)

4. (Optional) Generate MATLAB plots

   ![generated_matlab_plots](pictures/generated_matlab_plots.png)

### Save as .mat

> [!TIP]
> The following operations are performed in the MATLAB Command Window launched by PSPICE.

1. Open the MATLAB Command Window and run the command `whos`

   ![matlab_command_window](pictures/matlab_command_window.png)

1. Move to the desired directory (by default, MATLAB's working directory may not allow saving)

   ```bash
   cd 'H:\My Drive\Share\HAND\ORCAD\paper'
   ```

1. Save the struct as a .mat file

   ```bash
   save('2025-3-30-hand-sim.mat', 'PSpiceData_1');
   ```

## Complete Folder

This [Google Drive](https://drive.google.com/drive/folders/1SmM2jxRfvN7NogEErioShIMDqE8ifsSX?usp=sharing) contains the simulation results produced by the author. Key files include:

- `hand_pdn_v2.opj`: ORCAD project file
- `third_party`: IC models
- `hand_pdn_v2-PSpiceFiles\SCHEMATIC1\hand_pdn_v2\hand_pdn_v2.dat`: simulation data (ORCAD)
- `hand_pdn_v2-PSpiceFiles\SCHEMATIC1\hand_pdn_v2\hand_pdn_v2.prb`: simulation traces plotting information
- `complete_both_delay.mat` & `2025-3-30-hand-sim.mat`: extracted specific curves converted to `.mat`, which can be plotted using `plot_pspice.m`

## Parameters

### PSPICE Simulation Environments

- Analysis

  | name                              | value                   | description                                                         |
  | --------------------------------- | ----------------------- | ------------------------------------------------------------------- |
  | Analysis Type                     | Time Domain (Transient) | Type of simulation (transient time-domain)                          |
  | Run To Time                       | 35m                     | Total simulation duration (TSTOP)                                   |
  | Start Saving Data After           | 0.1m                    | Time after which waveform data will be stored                       |
  | Maximum Step Size                 | 2n                      | Maximum time step the solver is allowed to take                     |
  | Skip Initial Transient Bias Point | False                   | Whether to skip DC operating point calculation before transient sim |
  | Run in Resume Mode                | True                    | Whether to resume from previously saved simulation state            |

- Options ➞ Analog Advanced ➞ General

  | name        | value   | description                                                     |
  | ----------- | ------- | --------------------------------------------------------------- |
  | SPEED_LEVEL | 0       | solver speed level (0 = default, higher = faster/less accurate) |
  | RELTOL      | 0.005   | relative tolerance for voltage/current convergence              |
  | VNTOL       | 1e-6    | voltage error tolerance                                         |
  | ABSTOL      | 1e-9    | absolute current tolerance                                      |
  | CHGTOL      | 0.01p   | charge tolerance                                                |
  | GMIN        | 1.0e-12 | minimum conductance inserted to prevent floating nodes          |
  | ITL1        | 150     | max iterations for DC bias point                                |
  | ITL2        | 20      | max iterations for source stepping                              |
  | ITL4        | 10      | max iterations for transient solver                             |
  | TNOM        | 27.0    | nominal operating temperature (°C)                              |
  | THREADS     | 0       | number of threads used in simulation                            |
  | ADVCONV     | True    | enables advanced convergence algorithm                          |

- Options ➞ Analog Simulation ➞ Auto Converge

  | name         | value   | description                                                  |
  | ------------ | ------- | ------------------------------------------------------------ |
  | AutoConverge | True    | enables automatic convergence feature                        |
  | ITL1         | 1000    | max iterations for DC bias point calculation (Newton loops)  |
  | ITL2         | 1000    | max iterations for source stepping algorithm                 |
  | ITL4         | 1000    | max iterations for transient operating point calculation     |
  | RELTOL       | 0.05    | relative tolerance for convergence                           |
  | ABSTOL       | 1.0e-6  | absolute tolerance on current                                |
  | VNTOL        | 0.001   | voltage error tolerance                                      |
  | PIVTOL       | 1.0e-10 | pivot tolerance in matrix solver                             |
  | Restart      | True    | enables restart of simulation in case of convergence failure |

- Options ➞ Analog Advanced ➞ Bias Point

  | name       | value | description                                          |
  | ---------- | ----- | ---------------------------------------------------- |
  | STEPMIN    | False | enables minimum step control during bias calculation |
  | GMINSTEPS  | 0     | number of GMIN stepping steps                        |
  | NOSTEPSRC  | False | disables source stepping                             |
  | ITL6       | 0     | max iterations for bias point convergence            |
  | NOSTEPDEP  | False | disables dependent source stepping                   |
  | GMINSRC    | False | enables GMIN stepping on sources                     |
  | PSEUDOTRAN | False | enables pseudotransient simulation                   |
  | PTRANSTEP  | 0     | number of steps for pseudotransient stepping         |

- Options ➞ Analog Advanced ➞ Transient

  | name        | value   | description                                                  |
  | ----------- | ------- | ------------------------------------------------------------ |
  | METHOD      | Default | numerical integration method (e.g., Gear, Trapezoidal, etc.) |
  | TRTOL       | 7       | truncation error tolerance (affects adaptive timestep)       |
  | CSHUNT      | Disable | enables global shunt capacitor                               |
  | TRANCONV    | False   | enables convergence override for transient                   |
  | IGMOS       | False   | enables improved MOSFET modeling                             |
  | DEBUG       | 0       | debug level (0 = off)                                        |
  | DEBUG_START | Disable | start time for debug data collection                         |
  | DEBUG_END   | Disable | end time for debug data collection                           |

- Options ➞ Gate Level Simulation ➞ Advanced

  | name         | value | description                      |
  | ------------ | ----- | -------------------------------- |
  | DIGDRVF      | 2.0   | Digital driver fall delay        |
  | DIGDRVZ      | 20K   | Digital driver high-Z delay      |
  | DIGOVRDRV    | 3.0   | Digital overdrive factor         |
  | DIGMNTYSCALE | 0.4   | Digital minimum transition scale |
  | DIGTYMXSCALE | 1.6   | Digital maximum transition scale |
  | DIGERDEFAULT | 20.0  | Default digital event resolution |
  | DIGERLIMIT   | 0     | Digital event resolution limit   |

- Data Collection

  | name                           | value                        | description                           |
  | ------------------------------ | ---------------------------- | ------------------------------------- |
  | Voltages                       | All but Internal Subcircuits | Scope of voltage data to be collected |
  | Current                        | All but Internal Subcircuits | Scope of current data to be collected |
  | Power                          | All but Internal Subcircuits | Scope of power data to be collected   |
  | Digital                        | All but Internal Subcircuits | Scope of digital data to be collected |
  | Noise                          | All but Internal Subcircuits | Scope of noise data to be collected   |
  | Probe Data Format              | 64-bit                       | Data resolution (32-bit or 64-bit)    |
  | Save data in CSDF format (CSD) | False                        | Whether to export data in CSDF format |

### Simulation Paramters

| name       | value | description                                                           |
| ---------- | ----- | --------------------------------------------------------------------- |
| VBAT_VALUE | 3.7V  | battery voltage (constant)                                            |
| VBUS_VALUE | 5.25V | USB voltage (constant)                                                |
| V5V_VALUE  | 5V    | expected TPS61023 output voltage, used for equivalent resistance calc |
| I5V_VALUE  | 0.6A  | assumed load current drawn by backend circuit (constant)              |
| V3V3_VALUE | 3.3V  | expected TPS63806 output voltage, used for equivalent resistance calc |
| I3V3_VALUE | 0.4A  | assumed load current drawn by backend circuit (constant)              |
| T3         | 20 ms | USB plugin time                                                       |
| T4         | 27 ms | USB unplug time                                                       |

### Library

| relative path                                       | description          |
| --------------------------------------------------- | -------------------- |
| .\third_party\titps63805\tps63805_trans.lib         | Library include file |
| .\third_party\titps63806\tps63806_trans.lib         | Library include file |
| .\third_party\titps61023\library\tps61023_trans.lib | Library include file |
| .\third_party\diode\inc\dp2035uvt.lib               | Library include file |
| .\third_party\titps22965\tps22965_trans.lib         | Library include file |
| .\third_party\murata\ferrite bead\blm18sg700tz1.lib | Library include file |
| nom.lib                                             | Nominal library file |
| c:\cadence\spb_22.1\tools\PSpice\Library            | Default library path |

```

```
