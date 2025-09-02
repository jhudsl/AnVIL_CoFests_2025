# AnVIL 101

Led by: Ava Hoffman, Fred Hutch Cancer Center

<br><br>

AnVIL Outreach coordinators: 

Elizabeth Humphries, Fred Hutch Cancer Center
Kate Isaac, Fred Hutch Cancer Center
Natalie Kucher, Johns Hopkins University
Stephen Mosher, Johns Hopkins University

## About

This track will consist of both an overview and a hands-on workshop to provide individuals with a starting point to their work on AnVIL.

Participants are not required to supply their own data, as publicly available data and an AnVIL workspace will be provided as part of the CoFest track.

You can follow along with the agenda on Google Docs [here](https://docs.google.com/document/d/1P_Dgiv5YEVagXI0uObR7ajAoyWGof94A9PhffB1HSVg/edit?tab=t.0).

## Workspace

The workspace for this track can be found at: 

https://anvil.terra.bio/#workspaces/anvil-outreach/AnVIL101-CoFest2025 

## Data on AnVIL

Gathering your data is one of the first steps of any analysis (assuming you already have your research question in mind!). Working on AnVIL, you might be using data from a few different places:

- Data already on AnVIL (or GCP)
- Data from a public repository (such as [SRA](https://www.ncbi.nlm.nih.gov/sra))
- Data from a protected source (such as [dbGaP](https://dbgap.ncbi.nlm.nih.gov/home))
- Data from your own source (such as your laptop or an institutional HPC)

<!-- schematic of data sources -->

## Data already on AnVIL (or GCP)

Luckily, if data is already on AnVIL, there is less you have to do to start working with it. Under the hood, AnVIL uses [Google Cloud Platform](https://cloud.google.com/) (GCP) to store data. Each data file will therefore get a Google Cloud URI that starts with `gs://`. These URIs can be referenced inside workflows and copied into analysis environments.

> Within the context of Google Cloud Storage, the GCP URI is a Uniform Resource Identifier that points to a specific resource, such as a bucket or an object (file), within Cloud Storage.

Some consortia have created AnVIL Workspaces to organize their data. If you clone (copy) these workspaces, links to the data will be copied as well. You can then point to these links in WDL workflows, or copy these data into interactive compute environments (like Galaxy, RStudio, or Jupyter Notebooks/Terminal environment).

If your data is already stored in GCP, you can use the links directly.

## Data from a public repository

If our data is located elsewhere, such as in [SRA](https://www.ncbi.nlm.nih.gov/sra), we will need to bring the data into AnVIL/GCP storage. We could manually upload and download data, but that could take a long time, and might get interrupted if our computer or internet connection acts up. Better that we cut out the middle step, and have the SRA talk directly to AnVIL!

In the next steps, we'll copy over some SRA data (in FASTQ format) to AnVIL. Our goal is to get some RNA-Seq data associated with [this study](https://pubmed.ncbi.nlm.nih.gov/31150625/).

### Data from SRA

1. Clone the Workspace. Use the billing project provided by your instructor, or one of your choice. You might want to call the workspace "AnVIL101-CoFest2025-{your name here}", because workspace names on the same billing project must be unique.

2. Go to the "WORKFLOWS" tab. We'll use a WDL workflow to make sure the SRA data is in GCP and accessible in AnVIL.

3. Click "Find a Workflow". Click on "Dockstore.org". 

4. Once on Dockstore, browse for "SRA fetch". Scroll down a bit to find "aofarrel/SRANWRP/pull_FASTQs_from_SRA_by_run". Click on this workflow, or go directly to it [here](https://dockstore.org/workflows/github.com/aofarrel/SRANWRP/pull_FASTQs_from_SRA_by_run:v1.1.18?tab=info). 

5. On the righthand side, find "Launch with" and select "AnVIL". On the dropdown for "Destination Workspace" select the workspace clone you made above ("AnVIL101-CoFest2025-{your name here}").

6. Back on AnVIL, select the workflow you just imported ("pull_FASTQs_from_SRA_by_run").

7. In the box under "Input value" for the "sra_accessions" variable, enter an SRA accession listed at the site here: https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP131764&o=acc_s%3Aa. It should start with "SRR". Don't forget quotation marks (e.g., "SRR6652526").

8. Click the "Save" button. Then, click "Launch". Click "Launch" again to confirm. It will take 5-6 minutes.

### Buckets and persistent disks

By running the workflow above, we brought some data into GCP using AnVIL, into something called a "bucket". A Google bucket, more formally known as a Cloud Storage bucket, is a fundamental container for data in Google Cloud Storage. Buckets are used to organize objects (files of any format) and control access to them.

On AnVIL, you'll need to think about storage and computing being different computers. We'll have to move any data we want to analyze into a computing environment's "persistent disk".

1. While your workflow submitted above is running, launch a Jupyter notebook. Go to "ANALYSES" tab, click "Start" and name your notebook. Default parameters and Python can be used.

2. After the Jupyter environment starts provisioning, check the status of your workflow under the "SUBMISSION HISTORY" tab. Click on the "Submission ID" to see the output on GCP.

3. Locate your files by clicking through the folders. On the three-dot menu, you can copy the gsutil URI. We can use this link to bring our data into an AnVIL compute environment.

4. Navigate back to the Jupyter Notebook. Click the "Terminal" icon on the righthand side. Check out the files you have in this compute environment with `ls`. You can also see the GCP info, including the workspace bucket with `gcloud storage ls`.

> Remember that GCP storage (data "in the workspace") differs from the temporary storage associated with a Jupyter computing environment's persistent disk. You'll need to move data back and forth.

5. Bring data into this computing environment: `gcloud storage cp {URI HERE} .`. Type `ls` again to confirm the file is now available for you to work with.

In the next steps, we'll shift gears a bit to examine some processed data.

## Data from a protected source

You can also use workflows to get data from a protected source. 

For example, you can use workflows to get data from [dbGaP](https://dbgap.ncbi.nlm.nih.gov/home), if it's not already available on AnVIL/GCP somewhere. Here are two WDL workflows in [Dockstore](https://dockstore.org/) for doing this type of work:

- From the Broad Institute’s Manning Lab: `manning-lab/fetch-dbgap-data-workflow`
- From the UW Genetic Analysis Center: `UW-GAC/fetch-dbgap-files`

## Bring your own data

If you are bringing your own data to AnVIL, you'll likely need to transfer data from an institutional high-performance computing (HPC) resource or from your personal computer.

HPC access and setups vary from institution to institution. Here, we'll walk through how to upload a file from your computer. 

1. Click on the "DATA" tab. Locate the "Browse workspace files" icon on the righthand side.

2. Click the "Upload" button and upload this file: https://genomicseducation.org/data/mouse_gutbrain_de_counts_controls.csv. You might need to right-click to save this file to your local machine.

3. Navigate to the "ANALYSES" tab. Select the `mouse_gutbrain_DE.ipynb` notebook. Click "Open".

4. Follow along with the instructions in the notebook to perform some analyses!

## Shut down environments

A good practice to control costs is to shut down any computing environments when you're done. This:

- Deletes any data you imported or created in your persistent disk
- DOES NOT delete any data in the workspace bucket or code in .ipynb notebooks

For this activity, you can keep environments going if you want to continue to experiment. We will shut down the environment automatically at the end of the day. If you want to shut things down immediately, you should:

1. Click on the Jupyter logo. Click on "Settings".

2. Click on "Delete Environment". Select "Delete everything, including persistent disk" and click "Delete".

> You can also go to https://anvil.terra.bio/#clusters to see if you are accruing any analysis costs.
