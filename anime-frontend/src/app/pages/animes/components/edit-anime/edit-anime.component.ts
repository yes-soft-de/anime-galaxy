import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { ListCategory } from 'src/app/pages/categories/entity/list-category';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { Anime } from '../../entity/anime';
import { AnimeResponse } from '../../entity/anime-response';
import { ImageSnippet } from '../../entity/image-snippet';
import { AnimeService } from '../../services/anime.service';
import { DatePipe } from '@angular/common';
import { HelperService } from 'src/app/@theme/helper/helper.service';

@Component({
  selector: 'app-edit-anime',
  templateUrl: './edit-anime.component.html',
  styleUrls: ['./edit-anime.component.scss'],
  providers: [DatePipe]
})
export class EditAnimeComponent implements OnInit {
  mergeResult: {
    categories: ListCategoryResponse,
    anime: AnimeResponse
  }
  animeData: Anime;
  // allCategories: ListCategory[];
  generalRating = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
  animeID: number;
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  fileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  imageName = 'Leave it if you don\'t want to change image';
  imagePathReady = true;
  submitButtonValue = 'Update Anime';
  selectedFile: ImageSnippet;

  constructor(private animeService: AnimeService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private datePipe: DatePipe,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    // get Anime Id
    this.animeID = parseInt(this.activatedRoute.snapshot.paramMap.get('id'));

    const categories: Observable<ListCategoryResponse> = this.categoryService.allCategories();
    const anime: Observable<AnimeResponse> = this.animeService.getAnime(this.animeID); 

    const result: Observable<any> = categories.pipe(
      mergeMap(categoriesResponse => {
        return anime.pipe(map(animeResponse => {
          const result = {
            categories: categoriesResponse,
            anime: animeResponse
          };
          return result;
        }))
      })
    )
    result.subscribe(data => {
      this.mergeResult = data;
      this.animeData = this.mergeResult.anime.Data;
      this.updateFormValues();
    });


    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      mainImage: [''],
      description: ['', [Validators.required, Validators.minLength(2)]],
      trailerVideo: ['', [Validators.required, Validators.minLength(2)]],
      episodesCount: ['', Validators.required],
      publishDate: ['', Validators.required],
      categoryID: ['', Validators.required],
      ageGroup: ['', Validators.required],
      generalRating: ['', Validators.required],
      // suggest: ['', Validators.required]
    });
  }

  updateFormValues() {
    this.uploadForm.patchValue({
      name: this.animeData.name,
      mainImage: this.animeData.mainImage,
      description: this.animeData.description,
      trailerVideo: this.animeData.trailerVideo,
      episodesCount: this.animeData.episodesCount,
      publishDate: this.datePipe.transform(new Date(this.animeData.publishDate.timestamp * 1000), 'yyyy-MM-dd'),
      categoryID: this.animeData.categoryID,  // we must use the id not the name to make relate with select html tag
      ageGroup: this.animeData.ageGroup,
      generalRating: this.animeData.generalRating,
    });
  }

  // Choose Category Using Select Dropdown
  changeCategory(event) {
    this.uploadForm.get('categoryID').setValue(event.target.value, {
      onlySelf : true
    });
  }

    // Choose General Rating Using Select Dropdown
    changeGeneralRating(event) {
      this.uploadForm.get('generalRating').setValue(event.target.value, {
        onlySelf : true
      });
    }
  
  // changeSuggest(event) {
  //   this.uploadForm.get('suggest').setValue(event.target.value, {
  //     onlySelf: true
  //   });
  // }
  
  // Get Image Information 
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  // Upload Image
  processFile(imageInput: any) {
    this.imagePathReady = false;
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'Update Anime';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  // Submit THe Form
  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      formObject.id = this.animeID;
      if (this.imageUrl) {
        formObject.mainImage = this.imageUrl;
      } else {
        formObject.mainImage = this.animeData.imageURL;
      }
      this.animeService.updateAnime(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }

}
