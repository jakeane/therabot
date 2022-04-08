class MessagingStrings {
  static const List<String> suppressFeedbackText = [
    "Hold on, I'm thinking...",
    "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having."
  ];

  static const List<String> botInitPhrases = [
    "Welcome to the overworld for the ParlAI messenger chatbot demo. Please type \"begin\" to start, or \"exit\" to exit",
    "Welcome to the ParlAI Chatbot demo. You are now paired with a bot - feel free to send a message.Type [DONE] to finish the chat, or [RESET] to reset the dialogue history."
  ];

  static const String welcomeMessage =
      "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having.";

  static const String convoInit = '{"text": "Hi"}';
  static const String convoBegin = '{"text": "Begin"}';
  static const String convoDone = '{"text": "[DONE]"}';
  static const String convoExit = '{"text": "[EXIT]"}';

  static String getConvoBegin(String convo) {
    return '{"text": "begin", "payload": $convo}';
  }

  static const String emojiFilter =
      r"(\u00a9|\u00ae|[\u2028-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])";
  
    static const List<String> demoPrompts = [
    // eating disorder prompts
    "Many people have issues with their weight and shape. I'm designed to help with this. Do you have concerns about your weight and shape?",
    "What would it mean for you if your body image improved? Would this change the way you live your life (your behavior or experiences) or impact how comfortable you feel?",
    "How do you feel about your relationship with food? If food dominates your life, what would your life be like if things were different?",
    "Did you know that comparing your body to others can make you feel worse about yourself?",
    "How do you think people see you as a person in relation to your body? Do you see yourself the same way?",
    "What is your usual reaction when you are feeling guilty or upset about food? Would you like to change it?",
    "Do you have conversations about your weight, dieting, or body shape with family or friends? These conversations often make people feel worse about themselves. Next time this happens, can you try to change the subject?",
    "Sometimes social media or TV creates unrealistic expectations for bodies and this can be triggering. Less than 4% of persons have body shapes that are portrayed in the media. How do you feel when you see promotions of certain-looking bodies?",
    "A lot of people long for the 'perfect' body, but in doing so they lose track of other things that are important to them. You have a limited amount of time, and when you spend time focusing on your body, it's taking the time away from other things. How important is having the 'perfect body' compared to spending time with family and friends, your school/work, and other aspects of your life?",
    "Many people say they 'feel fat'. These feelings are often associated with a triggering event. Do you ever feel this way? If so, what kinds of things trigger these feelings?",
    "What would your life look like if you didn't have any concerns about your eating, weight, or shape?",
    "When it comes to eating, are there things you have done that have made you feel better?",
    "When people focus on their bodies, they usually don't think about things that they like about themselves. What parts of yourself do you feel good about (humor, personality, relationships, personality, achievements)?",
    "Many people believe that thinness equals attractiveness equals happiness. Do you believe this? Do you think that all thin or attractive people are happy?",
    "What would be the pros and cons of trying to overcome your eating habits and/or body image perceptions?",
    "When you start to feel triggered, what might be something you could do to feel better? Some people enjoy taking a walk, playing with pets, listening to music, or making art.",
    "Did you know that many people tie their self worth to their physical body?",
    "Many people that struggle with their body image and their eating feel like they can control their lives better if they are restrictive. But seeking perfection can also be really distressing. How do you feel when you are trying to control how you look, feel, or eat?",
    "Sometimes people who want to control their diet do so by vomiting, purging, fasting, or overexercising, and this can be very difficult for your body to handle. If you find yourself engaging in these behaviors, what are some alternative behaviors that could be better for you in the long term?",
    "Weighing yourself can be really distressing. How does the scale make you feel?",
    "Many people find that weighing themselves frequently can be highly distressing, but still do it every day. Does the scale measure what's really important to you?",
    "Sometimes the media portrays dieting as healthy, and there are often times it can be unhealthy. What do you think of dieting?",
    "Sometimes pop culture messages teach us to value our bodies for how they look. What kinds of things could you do to remind yourself of this when you see unrealistic images in the media?",
    "What kinds of feelings do you experience when eating out at a restaurant with others?",
    "Some people find it relaxing to unplug once in a while and take a break to focus on self care. What might that look like for you?",
    "It's very common for people to fixate on the negatives in their lives and mostly ignore the positives. It can be comforting to embrace a more accurate perspective where you acknowledge both. Have you ever found yourself thinking more of the bad than the good when it comes to your progress?",
    "I recommend eating 3 meals a day and 2 or 3 snacks so that you are eating every 3 to 4 hours. People who don't do this often feel out of control and overeat because they feel starved after having gone too long without eating. How do you think this would be if you tried it?",
    "Many people feel like they either have too much control or too little control of what they eat or much they eat. What would it be like to find a balance?",
    // depression prompts
    "Many people experience depression as low interest, feeling down, feeling numb, or a loss of pleasure in doing things they'd normally enjoy. Can you describe what depression feels like for you?",
    "Depression can impact multiple areas of a person's life. What are some of the ways that depression has affected your life?",
    "Even though depression affects 1 in 10 people, it can feel really isolating. What are some ways depression is isolating for you?",
    "I want to help with your depression and to learn how to most effectively live with it. What do you think the consequences of feeling depressed are for you?",
    "People with depression often try many things to try to feel better. What kinds of things have you tried to reduce your depression?",
    "Changing depression can be challenging and it's important to be sure of your priorities. What are some reasons that motivate you to try to improve your depression?",
    "It can be overwhelming to think about trying to reduce feelings of depression. In what ways to do you stick with things that you know aren't working for you because trying to change feels impossible?",
    "Did you know that it is impossible to get rid of negative emotions? Although some negative feelings will always be part of life, what can you do to live with these feelings?",
    "People experiencing depression often have trouble falling or staying asleep. Going to bed and waking up at the same time can be very helpful. What's your experience with sleep or tiredness?",
    "What are your throughts on trying to keep a journal? Keeping a daily journal can be a great way for you to track your thought and mood patterns.",
    "When people are depressed they often lose interest in things they used to enjoy. What types of things would you enjoy if you weren't feeling depressed?",
    "Today, I'd like to challenge you to find something you can do that you used to find fulfilling. Sometimes doing an activity can help your depression even if you don't think you would enjoy it. How could you add that into your day today?",
    "Yesterday, we talked about doing something that leads you to feel productive or content. Could you think you could do something like that to do every day? How would that make you feel?",
    "Many people experience really negative thoughts about themselves or the world when they are depressed. What are some of the negative thoughts you've had when your depression gets bad?",
    "Today, let's talk about things in your life that you may have noticed make your mood worse. Could you identify some of them?",
    "What are some triggers for your depression, and what are some useful ways to address these triggers? An example of a trigger might be loneliness. A useful coping strategy might be calling a friend or joining a social club.",
    "It's often helpful for people with depression to have an action plan prepared for each day. What are some simple, enjoyable activities you could schedule?",
    "It's very common for people to focus on the negatives in their lives and mostly ignore the positives. It can be comforting to embrace a more accurate perspective where you acknowledge both. Have you ever found yourself thinking more of the bad than the good when it comes to your depression?",
    "Thoughts are very closely linked to feelings and behavior. For people with depression, sometimes negative thoughts become so automatic and routine that they go unrecognized. What are some of the thoughts you have when you get depressed?",
    "What are some strategies you might use today to start combating overly negative thought patterns?",
    "Have you ever found yourself focusing on a small mistake or negative experience but ignoring the positive aspects of the experience? This can be really common, but it's important to recognize this thought pattern so that you can remind yourself of the positives too.",
    "Sometimes, it's easy for people to see the world as black and white, where something is either good or bad, when it's usually more accurate to be somewhere in the middle. Do you think you could work on approaching your thoughts in a different way where you see things more in shades of gray?",
    "The way people talk to themselves is often really harsh, especially when they make mistakes. When you make a mistake, what are some ways you might respond to yourself? For example, think of how you might respond to a friend in a similar situation.",
    "Sometimes people with depression put excessive blame on themselves when something bad happens. This can make them feel so much worse. What are some instances when you've taken on excessive blame for something bad that has happenned?",
    "It's common for people to blame themselves for how they are feeling or for what they have or have not accomplished. Do you ever find yourself blaming yourself or feeling guilty?",
    "Depression can cause people to be more prone to emotional reasoning, where people assume something must be true because they feel a certain way about it. An example might be assuming an interview went badly because you feel poorly about it. What are some ways your feelings might influence the way you perceive events?",
    "Today, I'd like to help you work with your negative thoughts by trying to focus less on the negatives and put your life into perspective. If you experienced a stressful event, are there any ways that helped you grow or change? If you can't think of one right now, what kinds of personal skills would you like to build?",
    "When you're not feeling your best, it can be hard to keep looking forward. Even though it can feel really difficult, trying to help yourself feel better by doing something that you used to enjoy can feel rewarding. What kinds of things that you used to like would you be open to trying?",
    "Would you be open to trying to meditate today? It can involve focusing on staying in the present moment. It has been proven to be very helpful and relaxing for many with depression, and it might be worth a try.",
    // anxiety prompts
    "Can you describe your anxiety? Do you experience anxiety as worry, body tension, feeling on edge?",
    "Can you give me an example of what kinds of situations or feelings trigger your anxiety and worries?",
    "Did you know that changing your habits and behaviors requires consistent effort? It's often helpful to have a list of motivators that can keep you going. Can you list something that motivates you to want to deal with your anxiety?",
    "What kinds of things do you usually do when you feel anxious or nervous?",
    "What do you think life would be like if you learned to live with your anxiety?",
    "Did you know that it is impossible to get rid of anxiety for good? Anxiety is necessary for functioning and productivity, but it doesn't always have to feel overwhelming. What are some ways that anxiety has helped you in the past?",
    "It can be useful to keep track of your anxiety by writing in a diary or log. Would you be open to writing down your thoughts, emotions, behaviors, and situations related to anxiety daily?",
    "Did you know thoughts, feelings, and behaviors can affect each other? What are some thoughts you have that can impact the way you feel or how you act?",
    "Anxiety is often rooted in worries about the future. How do you normally deal with your worries?",
    "Would you be open to trying to meditate today? It has been proven to be helpful and relaxing for many with anxiety, and it might be worth a try at easing your worries.",
    "Did you know that people who are highly anxious often breath shallowly through their chest. Do you want to try breathing deeply though your belly?",
    "Could you describe how your anxiety is today? Think about both your physical sensations and your thoughts / emotions. Many people find that there anxiety lessens when they try to identify the both the physical and mental sensations.",
    "Did you know that avoiding what makes you anxious can actually increase your anxiety over the long run, even if it makes you feel better temporarily? What are some ways you've avoided things that make you anxious.",
    "One of the most effective techniques to reducing anxiety is approaching and accepting your anxiety rather than avoiding it? You can break it down little by by little until it doesn't the same situation doesn't provoke as much anxiety. How do you think this might be helpful to you?",
    "What is a situation that makes you feel anxious? We can brainstorm a plan to gradually approach the situation, so that anxiety doesn't have so much power over your life.",
    "Mindfulness is a practice where people try to be present by using calming and grounding techniques. With practice, mindfulness decreases feelings of being overwhelmed or anxious. What are some ways that mindfulness might help you when you experience anxiety?",
    "Today, I'd like to show you how you can tense and release your muscles to help with some of the physical sensations of anxiety. Would you like to try it?",
    "Do you find that you criticize yourself a lot?",
    "Today, I'd like to talk about opposite action, which is when you act the opposite of how you feel. For example, if you are feeling really shy and scared in a social situation, you can try to act brave or confidently instead. How are some ways you can imagine this helping your anxiety?",
    "What kinds of thoughts do you experience when you start to feel anxiety?",
    "It's very common for people to fixate on the negatives in their lives and mostly ignore the positives. It can be comforting to embrace a more accurate perspective where you acknowledge both. Have you ever found yourself thinking more of the bad than the good when it comes to your anxiety?",
    "Have you ever found yourself focusing on a small mistake or negative experience but ignoring the positive aspects of the experience? This can be really common, especially in people with anxiety, but it's important to recognize this thought pattern so that you can remind yourself of the positives too. Have you ever found yourself focusing on a small mistake or negative experience but ignoring the positive aspects of the experience? This can be really common, especially in people with anxiety, but it's important to recognize this thought pattern so that you can remind yourself of the positives too.",
    "Sometimes, it's easy for people to see the world as black and white, where something is either good or bad, when it's usually more accurate to be somewhere in the middle. Do you think you could work on approaching your thoughts in a different way where you see things more in shades of gray?",
    "Did you know for people with anxiety, most worries don't come true? What are some examples of instances where you've worried a lot about something that never ended up happenning?",
    "The way people talk to themselves is often really harsh, especially when they make mistakes. When you make a mistake, what are some ways you might respond to yourself? For example, think of how you might respond to a friend in a similar situation.",
    "Practicing techniques to deal with anxiety is a lot like exercise: you have to keep working to stay in shape. What do you think would be helpful to do when you start to feel anxious?",
    "What are some common worries you have about different parts of your life?"
  ];
}
