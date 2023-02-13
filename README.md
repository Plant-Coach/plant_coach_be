Please visit the main README [here](https://github.com/Plant-Coach) on the project's main page.


<details> 
    <summary>PLant Coach User Stories</summary>

#### Relevant details to define for consistency 

**List of details when you click on a plant**
`Plant Type: <string>`
`Name: <string>`
`Chose to start from seed?: <boolean>`
`Direct Seed Recommended: <boolean>`
`direct_seed_user_decision: <boolean>`
`Days to Maturity: <integer>`
`Hybrid Status: <integer>`
`Days to transplant before/after frost date: <integer>`
`Organic: <boolean>`
`Recommended Transplant Date: normal recommended date`
`Planting Status: <string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
`Recommended Seed Sewing Date: <date>`
`Actual Seed Sewing Date: <date>`
`Seedling Days To Transplant: <integer>`
`Actual Transplant Date: <date>`
`Override seed-start date?`
`chosen_overridden_seed-start_date`
`Override transplant date?`
`Chosen Overridden seed-start date`

**Key Attributes for Transition Changes**
    - Chose to start from seed?: `<boolean>`
    - Direct Seed Recommended: `<boolean>`
    - Direct Seed User Decision: `<boolean>`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
    - Recommended Seed Sewing Date: `<date>`
    - Actual Seed Sewing Date: `<date>`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `<date>`
    - Override seed-start date? (This is only used when the planting date is in the future)
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

# v1 User Stories

---
**Account Creation**
As a User
I can visit `/` and see an option to login or create an account
When I select "Create an Account"
I can create an account with name, email, password, and my zip code
And when I select "Create"
I am taken to an empty dashboard with columns for:
-`My Saved Plants`
-`Plants Waiting to Start`
-`Plants that can be Started by now`
-`Seedlings Growing Inside`
-`Planted Outside`
-`Weather Alerts`
-`My Reminders`
I see buttons for:
-`View Plant Coach Guides`
-`Add a Plant to my Personal List of Plants`
- Each icon on the list has an button to `Add to my Garden`.


---
**Basic Login**
As a registered, but unauthenticated User
I can visit `plantcoach.graden` and select `sign in`
And I am able to enter my email and password and select `"Sign In"`
And I am taken to my dashboard.

---
**Basic Logout**
As a registered, but unauthenticated User
I can visit `plantcoach.graden` and select `sign in`
And I am able to enter my email and password and select `"Sign In"`
And I am taken to my dashboard.
And I see a button that says "Log Out"
And when I click it, I am taken to a logout screen that says "Thank you for using Plant Coach"
And I see a button that says "Log In"
But I do not see a button that says "Log Out"

---
**Add plant to personal database**
As an authenticated user
When I visit my dashboard
I can click "Add a Plant to my Personal Database"
And I am taken to a screen to enter details for:
- Name (optional)
- Plant Type (REQUIRED)
- Days to Maturity (optional)
- Hybrid Status (optional)
- When to start the plant (optional)
- Organic? (checkbox) (optional)
When I click: `Add`
I see feedback that my plant has been added to my list of saved plants.
I am shown a planting guide for that plant type and see sections for:
-`Seed Guide`
-`Transplant Guide`
-`Harvest Guide`
I can select `Close` and see a message that says that I can still access these growing guides at any time.
I am taken back to my Kanban Board/Dashboard and see my newly-created Plant in the "My Saved Plants" list
with a button that says `I want to plant this`.

---
**Pre-purchased plant - Already Planted**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `yes` 
I am I asked `when?` where I can provide today's date.
I am returned to the dashboard where I see my plant in the `Planted Outside` column.
When I click on the plant, I see
    - Chose to start from seed?: `False`
    - Direct Seed Recommended: `No`
    - Direct Seed User Decision: `No`
    - Actual Transplant Date: `<Today's Date>`
    - Days to Maturity: `<harvest date - actual transplant date>`
    - Recommended Transplant Date: `normal recommended date`
    - Planting Status: `["transplanted_outside"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `<integer>`
    - Override seed-start date? "not started from seed"
    - chosen_overridden_seed-start_date nil
    - Override transplant date? "yes"
    - Chosen Overridden seed-start <Today's Date>

---
**Pre-purchased plant - Future Planting - App recommended timing**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `No`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the dashboard where I see my plant in the `Plants Waiting to Start` column.
And when I click on the plant
    - Chose to start from seed?: `False`
    - Direct Seed Recommended: `No`
    - Direct Seed User Decision: `No`
    - Actual Transplant Date: `Not yet Transplanted outside`
    - Days to Maturity: `<harvest date - actual transplant date>`
    - Recommended Transplant Date: `normal recommended date`
    - Planting Status: `["not_started"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `<integer>`
    -- Override seed-start date? No 
    - chosen_overridden_seed-start_date
    - Override transplant date? No
    - Chosen Overridden seed-start date


---
**Pre-purchased plant - future planting - overridden planting date**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `No`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `Set Manually`
and I can set the future plant date myself
I am returned to the dashboard where I see my plant in the `Plants Waiting to Start` column.
And when I click on the plant
    - Chose to start from seed?: `False`
    - Direct Seed Recommended: `No`
    - Direct Seed User Decision: `No`
    - Actual Transplant Date: `Not yet Transplanted outside`
    - Days to Maturity: `<harvest date - actual transplant date>`
    - Recommended Transplant Date: `normal recommended date`
    - Planting Status: `["not_started"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `<integer>`
    - Override seed-start date? Not started from seed
    - chosen_overridden_seed-start_date
    - Override transplant date? Yes
    - Chosen Overridden seed-start <user-chosen date>

---
**Start from Seed - future - starting inside**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plan to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Inside`
And a window appears that asks if I have already planted this.
When I select `No` 
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the dashboard where I see my plant in the `Plants Ready to Start` column.
And when I click on the plant,
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `false`
    - Direct Seed User Decision: `false`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
    - Recommended Seed Sewing Date: `<date>`
    - Actual Seed Sewing Date: `<date>`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `<date>`
    - Override seed-start date?
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

---
**Start from seed - today - inside**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plan to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Inside`
And a window appears that asks if I have already planted this.
When I select `Yes`
And I am asked when I started it and I can select todady's date.
I am returned to the dashboard where I see my plant in the `Started Indoors` column.
And when I click on the plant,
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `false`
    - Direct Seed User Decision: `false`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["started_indoors"]` 
    - Recommended Seed Sewing Date: `<date>`
    - Actual Seed Sewing Date: `Today's date`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `nil`
    - Override seed-start date?
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

 ---
**Start from seed - today - outside"**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plan to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Outside`
And a window appears that asks if I have already planted this.
When I select `Yes`
And I am asked when I started it and I can select todady's date.
I am returned to the dashboard where I see my plant in the `Planted Outside` column.
And when I click on the plant,
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `true`
    - Direct Seed User Decision: `true`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `nil`
    - Planting Status: `<string> ["direct_sewn_outside"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `<Today's Date>`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `nil`
    - Override seed-start date? 
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

---
**Direct-seed in the future**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plant to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Outside`
And a window appears that asks if I have already planted this.
When I select `no`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the Dashboard where I see my plant listed under `Plants Ready to Start`
And when I click on the plant,
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `true`
    - Direct Seed User Decision: `true`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["not_started"]` 
    - Recommended Seed Sewing Date: `<make this the same as the recommended transplant date, if there is one>`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `nil`
    - Actual Transplant Date: `<same as actual seed-sewing date>`
    - Override seed-start date? No
    - chosen_overridden_seed-start_date nil
    - Override transplant date? No
    - Chosen Overridden seed-start nil


---
**Start indoor seed**
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Plants Ready to Start` column that is also a plant I want to grow from seed,
I can change the status to `Seedlings Growing Inside`
I am asked when they were started
and I can select: `Today`
And I see the plant in the `Seedlings Growing Inside`.
And when I click on the plant,
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `true`
    - Direct Seed User Decision: `true`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
    - Recommended Seed Sewing Date: `<make this the same as the recommended transplant date, if there is one>`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `nil`
    - Actual Transplant Date: `<same as actual seed-sewing date>`
    - Override seed-start date? No
    - chosen_overridden_seed-start_date nil
    - Override transplant date? No
    - Chosen Overridden seed-start nil

---
**User Story in which a future seed-starting date is set by the user saying when they've already started a seed (should return an error)**
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Plants Ready to Start` column
I can change the status to `Seedlings Growing Inside`
I am asked when they were started
and when I select:
Select date
and select a date in the future,
I see a flash message that dates must only be today or in the past.
When I select an appropriate date,
I can select `Ok`
And I see the plant in the `Seedlings Growing Inside`.


### User Stories related to a User moving a plant from "started inside" to "transplanted outside"

---
***Change plant status from "started indoors" to "transplanted outside"**
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Seedlings Growing Inside` column,
I can change the status to `Planted Outside`
And I am asked when it was transplanted outside
And I can select todays date
And I am taken to the dashboard and see my plant in the `Planted Outside` column
And when I select the plant, I see:
    - Chose to start from seed?: `Yes`
    - Direct Seed Recommended: `false`
    - Direct Seed User Decision: `false`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `["transplanted_outside"]` 
    - Recommended Seed Sewing Date: `<date>`
    - Actual Seed Sewing Date: `<date>`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `<Today's Date>`
    - Override seed-start date? No
    - chosen_overridden_seed-start_date nil
    - Override transplant date? No
    - Chosen Overridden seed-start nil


### User Stories related to a user being shown a visual cue about an upcoming task
---
**Upcoming Seed Start - Inside**

---
**Upcoming Seed Start - Outside**

---
**Upcoming Seed Transplant Date**
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Seedlings Growing Inside` column,
And the plant is within a week of the date that it is recommended to be planted outside,
I see a visual indication of an upcoming event for the plant
When I click on it, I can see `Plant is nearing its transplant date`


### User Stories related to a user being shown a visual cue about an overdue task
---
**Seed Start Now- Inside**

---
**Seed Start Now - Outside**

---
**Seed Transplant Now**


### User Stories related to a user receiving a notification abodut and upcoming task

---
**Upcoming Seed Start - Inside**

---
**Upcoming Seed Start - Outside**

---
**Upcoming Seed Transplant Date**


### User Stories related to a user receiving a notification about a potentially overdue task---
**Seed Start Now- Inside**

---
**Seed Start Now - Outside**

---
**Seed Transplant Now**

### User Stories related to a User moving a planting status "backwards"

### User accessing the Planting Guide

---
**View Planting Guide from clicking on plant on the kanban board**
As an Authenticated User
When I visit my dashboard
And I click on the name of the plant that is in the `Planted Outside` column,
and I click the link to go to the plant guide
I am taken to a page where I see the complete information available in the plant guide

**View Planting Guides from a plant index page**

---
Move Plant backwards/accidental status update


## v2.0 Planned User Stories

### Add Personalized Reminders

### Add Journal entry to a garden_plant

### Scroll down to see a calendar where I can see the events of each garden plant


## v3.0 Planned User Stories

### View Harvest Timeframes on a Calendar

### Succession Planting Stories
</details>