# Build and Run

Necessary version to build this app is: **Flutter version `3.10.0`**

# Observations

## Complete documentation

1. [Architecture](./challenge/docs/en/architecture/architecture.md)
1. [Features Dart](./challenge/docs/en/features_dart/features_dart.md)
1. [Improvments](./challenge/docs/en/improvments/improvments.md)
1. [About Modules](./challenge/docs/en/modules/modules.md)
1. [Packages](./challenge/docs/en/packages/packages.md)
1. [Tests](./challenge/docs/en/tests/tests.md)
1. [Flows](./challenge/docs/en/flows/flow.md)

## Doubts about the challenge

I had one problem during the status 200, It has an error in the json, I imagine it's on purpose.

## New feature of dart language

I decided to go deeper and use the **Records** instead of some package like **dartz/fpdart** The idea was to reduce coupling with respect to packets. I tried to make the code as simple and uncoupled as possible.

Regarding the error classes like **UserErros, ApiErrors, HomeErrors**, I decided to use the **Sealed class** which has the objective of limiting our use control, in my view it fits like a glove since it forces the developer to maintain a pattern in this case.

## Bloc/Cubit issue

During the development I had a slight problem with the Bloc tests, in some situations, the test hung for 30 seconds. More information is on the link below, the solution is already implemented here

https://github.com/felangel/bloc/issues/3848
