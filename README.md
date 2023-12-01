# Project-Atisan
Colour Separation Using Evolutionary Algorithms For Forensic Images

Overview:

This project presents an innovative approach to forensic image analysis, focusing on the challenge of color separation in complex images. It explores the use of evolutionary algorithms to enhance the clarity and distinctness of visual information, which is crucial in forensic investigations and legal proceedings.


Problem Statement:

Forensic image analysis is vital in criminal investigations and legal contexts, where the authenticity and integrity of images are paramount. Traditional methods often rely on manual adjustments and standard filters, which can be time-consuming and imprecise. This project addresses the need for more efficient and accurate color separation techniques.


Color Separation Algorithm:

At the core of this project is an advanced colour separation algorithm designed to isolate specific colours within an image, crucial when dealing with overlapping or closely related colors that can obscure critical details or evidence.

Interactive Differential Evolutionary Algorithm (IDE):

We integrate Interactive Differential Evolution (IDE) with the colour separation process, allowing human operators to guide the optimization based on visual or expert judgment. This combination of human expertise and computational power aims to revolutionize image processing in forensic scenarios.

Challenges and Future Implementations:

The project identifies key challenges in forensic image analysis, such as complex image structures, manipulation detection, and adaptability to diverse cases. It proposes future implementations like K-Means color separation and SVM classifiers for multi-ink separation to further enhance the effectiveness of forensic image analysis.

Contributions and Questions:

This project is an ongoing effort to improve forensic image processing. We welcome contributions, suggestions, and discussions on further enhancing this technology.
For any questions or discussions, feel free to open an issue or contact the contributors.

How to use:

Running the Scripts
Initial Setup: Start by running final_test_case.m. This script sets up the initial parameters and demonstrates the basic functionality of the algorithm.

User Score Integration: The IDE algorithm iteratively asks for user scores based on the presented colour separation results. Your input as a user influences the direction of the optimization, ensuring that the algorithm converges towards a solution that meets specific forensic requirements.

Optimal Color Values: The algorithm aims to find the optimal values for desired and undesired colours in the image. These values are crucial for enhancing the clarity and distinctness of crucial details in forensic images.

Advanced Test Cases: After familiarizing yourself with final_test_case.m, proceed to final_test_case_3.m, final_test_case_4.m, and final_test_case_5.m. Each script presents more complex scenarios and demonstrates the algorithm's adaptability to various forensic challenges.

Final Results: Upon completion, the scripts will output the optimal values for desired and undesired colors. These values are used for the final color separation in forensic images, ensuring enhanced clarity and detail
