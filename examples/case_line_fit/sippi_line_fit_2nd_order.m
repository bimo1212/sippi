% sippi_linefit_2nd_order: Fiting line using SIPPI
clear all;close all
rand('seed',1);randn('seed',1);

%% LOAD DATA
load('sippi_linefit_data');

%% Setting up the prior model

% the intercept
im=1;
prior{im}.type='gaussian';
prior{im}.name='intercept';
prior{im}.m0=0;
prior{im}.std=30;
prior{im}.m_true=m_ref{1};

% 1st order, the gradient
im=2;
prior{im}.type='gaussian';
prior{im}.name='gradient';
prior{im}.m0=0;
prior{im}.std=4;
prior{im}.norm=80;
prior{im}.m_true=m_ref{2};

% 2nd order
im=3;
prior{im}.type='gaussian';
prior{im}.name='2nd';
prior{im}.m0=0;
prior{im}.std=1;
prior{im}.norm=80;
prior{im}.m_true=m_ref{3};

sippi_plot_prior_sample(prior)

%% Perform extended Metropolis sampling 
% set some MCMC options.
options.mcmc.nite=40000;
options.mcmc.i_sample=50;
options.mcmc.i_plot=2500;
options.txt='case_line_fit_2nd_order';

[options]=sippi_metropolis(data,prior,forward,options);
sippi_plot_prior_sample(options.txt);
sippi_plot_posterior(options.txt);
