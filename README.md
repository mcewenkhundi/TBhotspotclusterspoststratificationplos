
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Sensitivity analysis TBhotspotclusterspoststratificationplos: Analysis based postistratifed TB prevalence, unlike the primary analysis(<https://github.com/mcewenkhundi/TBhotspotclustersplos>) which is based only on non poststratified TB prevalence

<!-- badges: start -->
<!-- badges: end -->

The goal of TBhotspotclustersplos repository is to replicate the
analysis of the manuscript:

*“Neighbourhood prevalence-to-notification ratios for adult
bacteriologically-confirmed tuberculosis reveals hotspots of
underdiagnosis in Blantyre, Malawi”*

Authors: McEwen Khundi<sup>1,2</sup>, James R Carpenter<sup>1</sup>,
Elizabeth L Corbett<sup>1,2</sup>, Helena R A Feasey<sup>1,2</sup>,
Rebecca Nzawa Soko<sup>1,2</sup>, Marriott Nliwasa<sup>1,3</sup>,
Hussein Twabi<sup>3</sup>, Lingstone Chiume<sup>1</sup>, Rachael M
Burke<sup>1,2</sup>, Katherine C Horton<sup>2</sup>, Peter J
Dodd<sup>4</sup>, Ted Cohen<sup>5</sup>, Peter
MacPherson<sup>1,2</sup>,<sup>6</sup>

1.  Malawi-Liverpool-Wellcome Trust Clinical Research Programme,
    Blantyre, Malawi,
2.  London School of Hygiene and Tropical Medicine, UK,
3.  Helse Nord TB Initiative, College of Medicine, University of Malawi,
4.  School of Health and Related Research, University of Sheffield,
    Sheffield, UK,
5.  Yale School of Public Health, New Haven, USA,
6.  Department of Clinical Sciences, Liverpool School of Tropical
    Medicine, UK

<br>

## Replicable code (Rscript folder description)

Description of the analysis scripts and source script of each output in
the analysis

1.  1_PoststratificationTBprevalence.Rmd

    -   Script for producing poststratified TB prevalence based on a
        world pop population of urban Blantyre.

2.  2_postratifiedPrevModel.R

    -   Script for producing a model of prevalance based on the
        postratified TB prevalance cases

3.  3_derive_posteriors_rintc_2021-09-29.Rmd

    -   Script for deriving posterior samples from the selected final
        models and also calculating the prevalence to notification
        ratios
    -   the notification model was copied from the primary analysis
        repository.

4.  4_exploratory_analysis_posterior_rintc_2021-09-29.Rmd

    -   Exploratory analysis of the posterior samples generated in part
        3 including graphs
    -   Source of S1_Fig.tiff and S3_Fig.tiff

5.  5_Model_table_results.R

    -   Source of S7_prev_models_rintc.rtf

6.  6_Comparisongraph.R

    -   Source of S2_Fig.tiff

7.  7_Comparisongraph.R

    -   Source of S9_Table_tablecompare_prev31_notif25_all.rtf

<br>

## Data

### **`dat_scale.rds`**
