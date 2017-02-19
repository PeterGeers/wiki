# wiki

This is the github page for My wikilinks. Wikilinks a view on public available Computing news wrt. Cloud, innovation, Trends, Security

<h1>Summary</h1>
<p>This application shows the word cloud of tags used in my Wiki. My Wiki is a collection of over 2400 articles wrt IT trends and innovation. Each article consists out of:</p>
<ol>
<li> a short decription</li>
<li> an url that points /links to the original source of the article</li>
<li> tags, a few items that supports the retrieval of a articles linked to specific verbs</li>
<li> a date field showing the date entered manually</li>
<li> a date field (system date and time) added by the system </li>
</ol>
<p>The content is created using a google form and the input is stored in a google sheet. This application reads the content from the google sheet and processes the data set</p>

<h2>Application</h2>
<p>In the sidebar the user can select 3 parameters</p>
<ol>
<li> Select a tag name from a limited list to build the wordcloud on</li>
<li> The minimal frequency any tag, within the subset created by the first parameter, must be used in the dataset to be shown in the word cloud</li>
<li> The maximum nr of words that may be used to build the word cloud. If the maximum available tags for the subset are lower then the maximum the output is limted to the maximum available.</li>
</ol>
<h2>3 panels</h2>
<p>The main window has 3 panels:</p>
<ol>
<li> Panel 1 is the plot window showing the wordcloud</li>
<li> Panel 2 is this window with the summary</li>
<li> Panel 3 shows a subset opf the data</li>
</ol>
