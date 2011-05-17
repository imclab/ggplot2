\name{stat_smooth}
\alias{stat_smooth}
\title{Add a smoother.}

\description{
  Add a smoother.
}

\details{
  Aids the eye in seeing patterns in the presence of
  overplotting.
}
\value{a data.frame with additional columns 
\item{y}{predicted value}
\item{ymin}{lower pointwise confidence interval around the mean}
\item{ymax}{upper pointwise confidence interval around the mean}
\item{se}{standard error}}
\seealso{\code{\link{lm}} for linear smooths,
\code{\link{glm}} for generalised linear smooths,
\code{\link{loess}} for local smooths}
\arguments{
  \item{method}{smoothing method (function) to use, eg. lm, glm, gam, loess,
rlm}
  \item{formula}{formula to use in smoothing function, eg. \code{y ~ x}, 
\code{y ~ poly(x, 2)}, \code{y ~ log(x)}}
  \item{se}{display confidence interval around smooth? (TRUE by default, see
level to control}
  \item{fullrange}{should the fit span the full range of the plot, or just
the data}
  \item{level}{level of confidence interval to use (0.95 by default)}
  \item{n}{number of points to evaluate smoother at}
  \item{xseq}{exact points to evaluate smooth at, overrides n}
  \item{...}{other arguments are passed to smoothing function}
}
\examples{c <- ggplot(mtcars, aes(qsec, wt))
c + stat_smooth() 
c + stat_smooth() + geom_point()

# Adjust parameters
c + stat_smooth(se = FALSE) + geom_point()

c + stat_smooth(span = 0.9) + geom_point()  
c + stat_smooth(method = "lm") + geom_point() 

library(splines)
c + stat_smooth(method = "lm", formula = y ~ ns(x,3)) +
geom_point()  
c + stat_smooth(method = MASS::rlm, formula= y ~ ns(x,3)) + geom_point()  

# The default confidence band uses a transparent colour. 
# This currently only works on a limited number of graphics devices 
# (including Quartz, PDF, and Cairo) so you may need to set the
# fill colour to a opaque colour, as shown below
c + stat_smooth(fill = "grey50", size = 2, alpha = 1)
c + stat_smooth(fill = "blue", size = 2, alpha = 1)

# The colour of the line can be controlled with the colour aesthetic
c + stat_smooth(fill="blue", colour="darkblue", size=2)
c + stat_smooth(fill="blue", colour="darkblue", size=2, alpha = 0.2)
c + geom_point() + 
stat_smooth(fill="blue", colour="darkblue", size=2, alpha = 0.2)

# Smoothers for subsets
c <- ggplot(mtcars, aes(y=wt, x=mpg)) + facet_grid(. ~ cyl)
c + stat_smooth(method=lm) + geom_point() 
c + stat_smooth(method=lm, fullrange=T) + geom_point() 

# Geoms and stats are automatically split by aesthetics that are factors
c <- ggplot(mtcars, aes(y=wt, x=mpg, colour=factor(cyl)))
c + stat_smooth(method=lm) + geom_point() 
c + stat_smooth(method=lm, aes(fill = factor(cyl))) + geom_point() 
c + stat_smooth(method=lm, fullrange=TRUE, alpha = 0.1) + geom_point() 

# Use qplot instead
qplot(qsec, wt, data=mtcars, geom=c("smooth", "point"))

# Example with logistic regression
data("kyphosis", package="rpart")
qplot(Age, Kyphosis, data=kyphosis)
qplot(Age, data=kyphosis, facets = . ~ Kyphosis, binwidth = 10)
qplot(Age, Kyphosis, data=kyphosis, position="jitter")
qplot(Age, Kyphosis, data=kyphosis, position=position_jitter(height=0.1))

qplot(Age, as.numeric(Kyphosis) - 1, data = kyphosis) +
stat_smooth(method="glm", family="binomial")
qplot(Age, as.numeric(Kyphosis) - 1, data=kyphosis) +
stat_smooth(method="glm", family="binomial", formula = y ~ ns(x, 2))}